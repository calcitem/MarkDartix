import 'dart:async';
import 'package:your_package_name/util.dart';
import 'package:your_package_name/bus.dart';

class TrailingNewlineCommand {
  TrailingNewlineCommand(this._editorState) {
    id = 'file.trailing-newline';
    description = 'File: Trailing Newline';
    placeholder = 'Select an option';

    subcommands = [];
    subcommandSelectedIndex = -1;
  }

  final dynamic _editorState;
  String id;
  String description;
  String placeholder;

  List<Map<String, dynamic>> subcommands;
  int subcommandSelectedIndex;

  static const List<String> descriptions = [
    'Trim all trailing newlines',
    'Ensure single newline',
    'Disabled'
  ];

  Future<void> run() async {
    int trimTrailingNewline =
        _editorState['currentFile']['trimTrailingNewline'];
    int index = trimTrailingNewline;
    if (index != 0 && index != 1) {
      index = 2;
    }

    subcommands = [
      {
        'id': 'file.trailing-newline-trim',
        'description': descriptions[0],
        'value': 0
      },
      {
        'id': 'file.trailing-newline-single',
        'description': descriptions[1],
        'value': 1
      },
      {
        'id': 'file.trailing-newline-disabled',
        'description': descriptions[2],
        'value': 3
      }
    ];
    subcommands[index]['description'] = '${descriptions[index]} - current';
    subcommandSelectedIndex = index;
  }

  Future<void> execute() async {
    // Timeout to hide the command palette and then show again to prevent issues.
    await Future.delayed(Duration(milliseconds: 100));
    bus.emit('show-command-palette', this);
  }

  void executeSubcommand(_, int value) {
    // TODO: Emit 'mt::set-final-newline' event with ipcRenderer
    // You need to implement the communication with your main process to handle this event
  }

  void unload() {}
}
