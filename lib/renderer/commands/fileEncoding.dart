import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_package_name/common/encoding.dart';
import 'package:your_package_name/util.dart';
import 'package:your_package_name/bus.dart';

class FileEncodingCommand {
  String id = 'file.change-encoding';
  String description = 'File: Change Encoding';
  String placeholder = 'Select an option';

  List<Subcommand> subcommands = [];
  int subcommandSelectedIndex = -1;

  // Reference to editor state.
  final dynamic _editorState;

  FileEncodingCommand(this._editorState);

  Future<void> run() async {
    subcommands = [];
    subcommandSelectedIndex = -1;

    // Load encoding from current tab to highlight it.
    Map<String, dynamic> encodingObj = _getCurrentEncoding();
    String encoding = encodingObj['encoding'];
    bool isBom = encodingObj['isBom'];

    // NOTE: We support UTF-BOM encodings but don't allow to set them.
    if (isBom) {
      subcommandSelectedIndex = 0;
      subcommands.add(Subcommand(
          id: '$encoding-bom',
          description: '${getEncodingName(encodingObj)} - current'));
    }

    int i = 0;
    for (MapEntry<String, String> entry in ENCODING_NAME_MAP.entries) {
      String key = entry.key;
      String value = entry.value;
      bool isTabEncoding = !isBom && key == encoding;
      Subcommand item = Subcommand(
          id: key, description: isTabEncoding ? '$value - current' : value);

      if (isTabEncoding) {
        // Highlight current encoding and set it as the first entry.
        subcommandSelectedIndex = i;
        subcommands.insert(0, item);
      } else {
        subcommands.add(item);
      }
      ++i;
    }
  }

  Future<void> execute() async {
    // Timeout to hide the command palette and then show again to prevent issues.
    await Future.delayed(Duration(milliseconds: 100));
    bus.emit('show-command-palette', this);
  }

  Future<void> executeSubcommand(String id) async {
    // NOTE: We support UTF-BOM encodings but don't allow to set them.
    if (!id.endsWith('-bom')) {
      // Emit event with your platform channel implementation.
      // Replace "yourMethodChannel" with your actual MethodChannel instance.
      await yourMethodChannel.invokeMethod('mt::set-file-encoding', id);
    }
  }

  void unload() {
    subcommands = [];
  }

  Map<String, dynamic> _getCurrentEncoding() {
    dynamic currentFile = _editorState['currentFile'];
    if (currentFile != null) {
      return currentFile['encoding'];
    }
    return {};
  }
}

class Subcommand {
  final String id;
  final String description;

  Subcommand({required this.id, required this.description});
}
