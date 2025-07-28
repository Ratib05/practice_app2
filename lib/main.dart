import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(), // App starts with HomePage
    ),
  );
}

// StatefulWidget allows the UI to change dynamically
class HomePage extends StatefulWidget {
  const HomePage({super.key}); // Constructor with key

  @override
  State<HomePage> createState() => _HomePageState(); // Connect state
}

class _HomePageState extends State<HomePage> {
  // Controller for a future input field (not used yet)
  final TextEditingController _controller = TextEditingController();

  // List of incidents to display
  final List<String> incidents = [
    'Malware found in email',
    'Unauthorized login detected',
    'Phishing attempt blocked',
  ];

  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cyber Tracker'), // App title
        backgroundColor: Colors.blue, // App bar color
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type Cyber incident here',
              ),
            ),
          ),
          // Expanded allows the ListView to take available space
          Expanded(
            child: ListView.builder(
              itemCount: incidents.length, // Number of list items
              itemBuilder: (context, index) {
                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _hoveredIndex = index;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _hoveredIndex = null;
                    });
                  },

                  child: Dismissible(
                    key: Key(incidents[index]),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        incidents.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Container(
                      color: _hoveredIndex == index
                          ? Colors.blue.shade100
                          : null,
                      child: ListTile(
                        leading: const Icon(Icons.warning, color: Colors.red),
                        title: Text(incidents[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adds a new incident when button is pressed
          setState(() {
            incidents.add(_controller.text);
            _controller.clear();
          });
        },
        child: const Icon(Icons.add), // Plus icon
      ),
    );
  }
}
