import 'package:flutter/material.dart';

class WindowMenu extends StatefulWidget {
  @override
  _WindowMenuState createState() => _WindowMenuState();
}

class _WindowMenuState extends State<WindowMenu> {
  bool _alwaysOnTop = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Minimize'),
          onTap: () {
            // Implement the action for minimizing the window.
          },
        ),
        CheckboxListTile(
          title: const Text('Always on Top'),
          value: _alwaysOnTop,
          onChanged: (bool? newValue) {
            setState(() {
              _alwaysOnTop = newValue!;
            });
            // Implement the action for toggling the Always on Top feature.
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Zoom In'),
          onTap: () {
            // Implement the action for zooming in.
          },
        ),
        ListTile(
          title: const Text('Zoom Out'),
          onTap: () {
            // Implement the action for zooming out.
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Show in Full Screen'),
          onTap: () {
            // Implement the action for toggling full-screen mode.
          },
        ),
      ],
    );
  }
}
