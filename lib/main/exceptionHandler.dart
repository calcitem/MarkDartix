import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const bool EXIT_ON_ERROR = true; // TODO: Adjust this based on your requirements
const bool SHOW_ERROR_DIALOG =
    true; // TODO: Adjust this based on your requirements
const String ERROR_MSG_MAIN =
    'An unexpected error occurred in the main process';
const String ERROR_MSG_RENDERER =
    'An unexpected error occurred in the renderer process';

String logger(String s) {
  stderr.writeln(s);
  return s;
}

String getOSInformation() {
  return '${Platform.operatingSystem} ${Platform.version}';
}

String exceptionToString(Object error, String type) {
  final message = error.toString();
  final stack = StackTrace.current.toString();
  return 'Version: 1.0.0\n' // TODO: Replace with your app's version
      'OS: ${getOSInformation()}\n'
      'Type: $type\n'
      'Date: ${DateTime.now().toUtc()}\n'
      'Message: $message\n'
      'Stack: $stack\n';
}

Future<void> handleError(String title, Object error, String type) async {
  final message = error.toString();
  final stack = StackTrace.current.toString();

  // Write error into file
  if (type == 'main') {
    logger(exceptionToString(error, type));
  }

  if (EXIT_ON_ERROR) {
    print(
        'App was terminated due to an unexpected error (EXIT_ON_ERROR variable was set)!');
    exit(1);
  } else if (!SHOW_ERROR_DIALOG) {
    return;
  }

  // TODO: Show error dialog using Flutter's showDialog or another approach.

  // Copy error and report error are not applicable in the same way as in Electron
  // You can use the Clipboard package to copy the error to the clipboard
  // and launch the issue report URL using the url_launcher package.

  Clipboard.setData(ClipboardData(text: '$title\n$stack'));
  String issueTitle = message.isNotEmpty ? 'Unexpected error: $message' : title;
  String issueUrl =
      'https://github.com/your_repo/your_project/issues/new?title=$issueTitle&body=$stack';
  if (await canLaunch(issueUrl)) {
    await launch(issueUrl);
  } else {
    throw 'Could not launch $issueUrl';
  }
}

void setupExceptionHandler() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    await handleError(ERROR_MSG_RENDERER, details.exception, 'renderer');
  };
}

void initExceptionLogger() {
  // replace placeholder logger
  logger = (String s) {
    stderr.writeln(s);
    return s;
  };
}
