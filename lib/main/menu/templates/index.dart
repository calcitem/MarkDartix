import 'package:flutter/material.dart';

class Templates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter AppBar Menu Example'),
          actions: [
            buildFileMenu(),
            buildEditMenu(),
            buildParagraphMenu(),
            buildFormatMenu(),
            buildWindowMenu(),
            buildThemeMenu(),
            buildViewMenu(),
            buildHelpMenu(),
          ],
        ),
        body: Center(child: Text('Example content')),
      ),
    );
  }

  PopupMenuButton buildFileMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.file_copy),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // Add file menu items here
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }

  PopupMenuButton buildEditMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.edit),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // Add edit menu items here
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }

  PopupMenuButton buildParagraphMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.format_align_left),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // Add paragraph menu items here
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }

  PopupMenuButton buildFormatMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.format_paint),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // Add format menu items here
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }

  PopupMenuButton buildWindowMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.aspect_ratio),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // Add window menu items here
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }

  PopupMenuButton buildThemeMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.color_lens),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // Add theme menu items here
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }

  PopupMenuButton buildViewMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.remove_red_eye),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // Add view menu items here
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }

  PopupMenuButton buildHelpMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.help),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // Add help menu items here
      ],
      onSelected: (value) {
        print('Selected menu item: $value');
      },
    );
  }
}
