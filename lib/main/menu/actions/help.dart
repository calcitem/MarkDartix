import 'package:flutter/material.dart';

void showAboutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AboutDialog(
        applicationName: 'Your App Name',
        applicationVersion: 'Your App Version',
        applicationIcon: Image.asset('path/to/your/app/icon'),
        children: <Widget>[
          Text('Your additional information here'),
        ],
      );
    },
  );
}

void showTweetDialog(BuildContext context, String type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Tweet $type'),
        content: Text('Your tweet dialog content here'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
