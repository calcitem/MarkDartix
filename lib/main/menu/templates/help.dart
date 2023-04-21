import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpMenu extends StatelessWidget {
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
          title: const Text('Quick Start'),
          onTap: () => _launchURL(
              'https://github.com/calcitem/markdartix/blob/master/docs/README.md'),
        ),
        ListTile(
          title: const Text('Markdown Reference'),
          onTap: () => _launchURL(
              'https://github.com/calcitem/markdartix/blob/master/docs/MARKDOWN_SYNTAX.md'),
        ),
        ListTile(
          title: const Text('Changelog'),
          onTap: () => _launchURL(
              'https://github.com/calcitem/markdartix/blob/master/.github/CHANGELOG.md'),
        ),
        const Divider(),
        ListTile(
          title: const Text('Donate via Open Collective'),
          onTap: () => _launchURL('https://opencollective.com/markdartix'),
        ),
        ListTile(
          title: const Text('Feedback via Twitter'),
          onTap: () => _launchURL('https://twitter.com/markdartixapp'),
        ),
        ListTile(
          title: const Text('Report Issue or Request Feature'),
          onTap: () =>
              _launchURL('https://github.com/calcitem/markdartix/issues'),
        ),
        const Divider(),
        ListTile(
          title: const Text('Website'),
          onTap: () => _launchURL('https://github.com/calcitem/markdartix'),
        ),
        ListTile(
          title: const Text('Watch on GitHub'),
          onTap: () => _launchURL('https://github.com/calcitem/markdartix'),
        ),
        ListTile(
          title: const Text('Follow us on Github'),
          onTap: () => _launchURL('https://github.com/Jocs'),
        ),
        ListTile(
          title: const Text('Follow us on Twitter'),
          onTap: () => _launchURL('https://twitter.com/markdartixapp'),
        ),
        const Divider(),
        ListTile(
          title: const Text('License'),
          onTap: () => _launchURL(
              'https://github.com/calcitem/markdartix/blob/master/LICENSE'),
        ),
        const Divider(),
        ListTile(
          title: const Text('Check for updates'),
          onTap: () {
            // Implement checkUpdates() logic here.
          },
        ),
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
      ],
    );
  }
}
