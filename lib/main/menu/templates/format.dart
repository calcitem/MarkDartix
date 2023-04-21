import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Format extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Format Menu Example'),
          actions: [
            buildFormatMenu(context),
          ],
        ),
        body: Center(child: Text('Example content')),
      ),
    );
  }

  PopupMenuButton buildFormatMenu(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        buildCheckedPopupMenuItem(
          context: context,
          value: 'bold',
          title: 'Bold',
          shortcut: 'format.strong',
        ),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'italic',
          title: 'Italic',
          shortcut: 'format.emphasis',
        ),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'underline',
          title: 'Underline',
          shortcut: 'format.underline',
        ),
        PopupMenuDivider(),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'superscript',
          title: 'Superscript',
          shortcut: 'format.superscript',
        ),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'subscript',
          title: 'Subscript',
          shortcut: 'format.subscript',
        ),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'highlight',
          title: 'Highlight',
          shortcut: 'format.highlight',
        ),
        PopupMenuDivider(),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'inlineCode',
          title: 'Inline Code',
          shortcut: 'format.inline-code',
        ),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'inlineMath',
          title: 'Inline Math',
          shortcut: 'format.inline-math',
        ),
        PopupMenuDivider(),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'strikethrough',
          title: 'Strikethrough',
          shortcut: 'format.strike',
        ),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'hyperlink',
          title: 'Hyperlink',
          shortcut: 'format.hyperlink',
        ),
        buildCheckedPopupMenuItem(
          context: context,
          value: 'image',
          title: 'Image',
          shortcut: 'format.image',
        ),
        PopupMenuDivider(),
        buildPopupMenuItem(
          context: context,
          value: 'clearFormatting',
          title: 'Clear Formatting',
          shortcut: 'format.clear-format',
        ),
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }

  CheckedPopupMenuItem buildCheckedPopupMenuItem({
    required BuildContext context,
    required String value,
    required String title,
    required String shortcut,
  }) {
    return CheckedPopupMenuItem(
      value: value,
      child: Text(title),
      checked: false,
      enabled: true,
      // Implement the accelerator/shortcut and click functionality here
    );
  }

  PopupMenuItem buildPopupMenuItem({
    required BuildContext context,
    required String value,
    required String title,
    required String shortcut,
  }) {
    return PopupMenuItem(
      value: value,
      child: Text(title),
      enabled: true,
// Implement the accelerator/shortcut and click functionality here
    );
  }
}
