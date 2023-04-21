import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MacOSMenu extends StatelessWidget {
  // Function to launch external URLs
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('About MarkDartix'),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('About MarkDartix'),
                  content: const Text('MarkDartix version info here.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        ListTile(
          title: const Text('Check for updates'),
          onTap: () {
            // Implement checkUpdates() logic here.
          },
        ),
        ListTile(
          title: const Text('Preferences'),
          onTap: () {
            // Implement userSetting() logic here.
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Services'),
          onTap: () {
            // Implement services logic here.
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Hide MarkDartix'),
          onTap: () {
            // Implement osxHide() logic here.
          },
        ),
        ListTile(
          title: const Text('Hide Others'),
          onTap: () {
            // Implement osxHideAll() logic here.
          },
        ),
        ListTile(
          title: const Text('Show All'),
          onTap: () {
            // Implement osxShowAll() logic here.
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Quit MarkDartix'),
          onTap: () {
            // Close the app
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
