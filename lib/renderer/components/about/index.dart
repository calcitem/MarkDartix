import 'package:flutter/material.dart';

class AboutDialog extends StatefulWidget {
  @override
  _AboutDialogState createState() => _AboutDialogState();
}

class _AboutDialogState extends State<AboutDialog> {
  String name = 'MarkDartix';
  String copyright = 'Copyright © 2017-${DateTime.now().year} Luo Ran';
  String copyrightContributors =
      'Copyright © 2018-${DateTime.now().year} MarkDartix Contributors';

  bool showAboutDialog = false;

  void showDialog() {
    setState(() {
      showAboutDialog = true;
    });
    // Emit 'editor-blur' event on the bus.
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showAboutDialog,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          width: 400,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 80,
                height: 80,
              ),
              SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'App version', // Replace with the actual app version
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                copyright,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                copyrightContributors,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
