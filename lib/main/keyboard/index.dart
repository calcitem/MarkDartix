import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:keyboard_info/keyboard_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

KeyboardInfo? _currentKeyboardInfo;

KeyboardInfo getKeyboardInfo() {
  if (_currentKeyboardInfo == null) {
    _currentKeyboardInfo = KeyboardInfo.getCurrent();
  }
  return _currentKeyboardInfo!;
}

class KeyboardLayoutMonitor {
  final _eventController = StreamController<KeyboardInfo>.broadcast();
  Stream<KeyboardInfo> get onChanged => _eventController.stream;

  KeyboardLayoutMonitor() {
    KeyboardInfo.onChange.listen((KeyboardInfo info) {
      _eventController.add(info);
      _currentKeyboardInfo = info;
    });
  }
}

final keyboardLayoutMonitor = KeyboardLayoutMonitor();

Future<void> dumpKeyboardInfo() async {
  final directory = await getTemporaryDirectory();
  final dumpPath = '${directory.path}/markdartix_keyboard_info.json';
  final content = jsonEncode(getKeyboardInfo().toMap());

  final file = LocalFileSystem().file(dumpPath);
  await file.writeAsString(content, mode: FileMode.write, encoding: utf8);

  print('Keyboard information written to "$dumpPath".');

  // Open the file using a platform-specific method (if needed)
}

void main() {
  print(getKeyboardInfo());

  // Listen to keyboard layout changes
  keyboardLayoutMonitor.onChanged.listen((info) {
    print('Keyboard layout changed: $info');
  });

  // Dump keyboard info (call this function based on your app's requirements)
  dumpKeyboardInfo();
}
