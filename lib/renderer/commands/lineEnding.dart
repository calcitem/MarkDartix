import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_package_name/util.dart';
import 'package:your_package_name/bus.dart';

const String crlfDescription = 'Carriage return and line feed (CRLF)';
const String lfDescription = 'Line feed (LF)';

class LineEndingCommand {
  String id = 'file.line-ending';
  String description = 'File: Change Line Ending';
  String placeholder = 'Select an option';

  List<Subcommand> subcommands = [
    Subcommand(
        id: 'file.line-ending-crlf',
        description: crlfDescription,
        value: 'crlf'),
    Subcommand(
        id: 'file.line-ending-lf', description: lfDescription, value: 'lf')
  ];
  int subcommandSelectedIndex = -1;

  // Reference to editor state.
  final dynamic _editorState;

  LineEndingCommand(this._editorState);

  Future<void> run() async {
    String lineEnding = _editorState['currentFile']['lineEnding'];
    if (lineEnding == 'crlf') {
      subcommandSelectedIndex = 0;
      subcommands[0].description = '$crlfDescription - current';
      subcommands[1].description = lfDescription;
    } else {
      subcommandSelectedIndex = 1;
      subcommands[0].description = crlfDescription;
      subcommands[1].description = '$lfDescription - current';
    }
  }

  Future<void> execute() async {
    // Timeout to hide the command palette and then show again to prevent issues.
    await Future.delayed(Duration(milliseconds: 100));
    bus.emit('show-command-palette', this);
  }

  Future<void> executeSubcommand(String id, String value) async {
    // Emit event with your platform channel implementation.
    // Replace "yourMethodChannel" with your actual MethodChannel instance.
    await yourMethodChannel.invokeMethod('mt::set-line-ending', value);
  }

  void unload() {}
}

class Subcommand {
  final String id;
  String description;
  final String value;

  Subcommand(
      {required this.id, required this.description, required this.value});
}
