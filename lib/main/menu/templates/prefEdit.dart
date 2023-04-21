import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Cut'),
          onTap: () {
            Clipboard.setData(ClipboardData(text: ''));
          },
        ),
        ListTile(
          title: const Text('Copy'),
          onTap: () {
            Clipboard.setData(ClipboardData(text: ''));
          },
        ),
        ListTile(
          title: const Text('Paste'),
          onTap: () {
            Clipboard.getData('text/plain');
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Select All'),
          onTap: () {
            // Implement the Select All functionality
          },
        ),
      ],
    );
  }
}
