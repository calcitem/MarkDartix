import 'package:flutter/material.dart';

class ViewMenu extends StatefulWidget {
  @override
  _ViewMenuState createState() => _ViewMenuState();
}

class _ViewMenuState extends State<ViewMenu> {
  bool _sourceCodeMode = false;
  bool _typewriterMode = false;
  bool _focusMode = false;
  bool _showSidebar = false;
  bool _showTabBar = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Command Palette...'),
          onTap: () {
            // Implement the action for showing the Command Palette.
          },
        ),
        const Divider(),
        CheckboxListTile(
          title: const Text('Source Code Mode'),
          value: _sourceCodeMode,
          onChanged: (bool? newValue) {
            setState(() {
              _sourceCodeMode = newValue!;
            });
            // Implement the action for toggling the Source Code Mode.
          },
        ),
        CheckboxListTile(
          title: const Text('Typewriter Mode'),
          value: _typewriterMode,
          onChanged: (bool? newValue) {
            setState(() {
              _typewriterMode = newValue!;
            });
            // Implement the action for toggling the Typewriter Mode.
          },
        ),
        CheckboxListTile(
          title: const Text('Focus Mode'),
          value: _focusMode,
          onChanged: (bool? newValue) {
            setState(() {
              _focusMode = newValue!;
            });
            // Implement the action for toggling the Focus Mode.
          },
        ),
        const Divider(),
        CheckboxListTile(
          title: const Text('Show Sidebar'),
          value: _showSidebar,
          onChanged: (bool? newValue) {
            setState(() {
              _showSidebar = newValue!;
            });
            // Implement the action for toggling the Sidebar visibility.
          },
        ),
        CheckboxListTile(
          title: const Text('Show Tab Bar'),
          value: _showTabBar,
          onChanged: (bool? newValue) {
            setState(() {
              _showTabBar = newValue!;
            });
            // Implement the action for toggling the Tab Bar visibility.
          },
        ),
        ListTile(
          title: const Text('Toggle Table of Contents'),
          onTap: () {
            // Implement the action for showing the Table of Contents.
          },
        ),
        ListTile(
          title: const Text('Reload Images'),
          onTap: () {
            // Implement the action for reloading images.
          },
        ),
      ],
    );
  }
}
