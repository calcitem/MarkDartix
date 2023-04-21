import 'package:flutter/material.dart';

class CommandPalette extends StatefulWidget {
  @override
  _CommandPaletteState createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<CommandPalette> {
  // TODO: Implement the necessary logic and state management based on your project requirements.
  // This is just a basic UI conversion.

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: TextField(
                      // Implement necessary logic for the TextField
                      decoration: InputDecoration(
                        hintText: 'Type a command to execute',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount:
                          10, // Replace with the actual number of commands
                      itemBuilder: (context, index) {
                        return ListTile(
                          // Implement the onTap logic for each ListTile
                          title: Text(
                              'Command Title'), // Replace with the command title
                          subtitle: Text(
                              'Shortcut'), // Replace with the command shortcut
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
