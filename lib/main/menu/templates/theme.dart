import 'package:flutter/material.dart';

class ThemeMenu extends StatefulWidget {
  @override
  _ThemeMenuState createState() => _ThemeMenuState();
}

class _ThemeMenuState extends State<ThemeMenu> {
  String _selectedTheme = 'light';

  void _selectTheme(String theme) {
    setState(() {
      _selectedTheme = theme;
    });
    // Implement the logic to apply the selected theme in your app.
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RadioListTile<String>(
          title: const Text('Cadmium Light'),
          value: 'light',
          groupValue: _selectedTheme,
          onChanged: _selectTheme,
        ),
        RadioListTile<String>(
          title: const Text('Dark'),
          value: 'dark',
          groupValue: _selectedTheme,
          onChanged: _selectTheme,
        ),
        RadioListTile<String>(
          title: const Text('Graphite Light'),
          value: 'graphite',
          groupValue: _selectedTheme,
          onChanged: _selectTheme,
        ),
        RadioListTile<String>(
          title: const Text('Material Dark'),
          value: 'material-dark',
          groupValue: _selectedTheme,
          onChanged: _selectTheme,
        ),
        RadioListTile<String>(
          title: const Text('One Dark'),
          value: 'one-dark',
          groupValue: _selectedTheme,
          onChanged: _selectTheme,
        ),
        RadioListTile<String>(
          title: const Text('Ulysses Light'),
          value: 'ulysses',
          groupValue: _selectedTheme,
          onChanged: _selectTheme,
        ),
      ],
    );
  }
}
