import 'file.dart'; // Import the converted file.dart and tab.dart files
import 'tab.dart';

const COMMANDS = COMMAND_CONSTANTS;

void loadDefaultCommands(CommandManager commandManager) {
  loadFileCommands(commandManager);
  loadTabCommands(commandManager);
}

class CommandManager {
  CommandManager() {
    _commands = <String, Function>{};
  }

  Map<String, Function> _commands;

  void add(String id, Function callback) {
    if (_commands.containsKey(id)) {
      throw Exception('Command with id="$id" already exists.');
    }
    _commands[id] = callback;
  }

  bool remove(String id) {
    return _commands.remove(id) != null;
  }

  bool has(String id) {
    return _commands.containsKey(id);
  }

  dynamic execute(String id, List<dynamic> args) {
    final command = _commands[id];
    if (command == null) {
      throw Exception('No command found with id="$id".');
    }
    return Function.apply(command, args);
  }

  void _verifyDefaultCommands() {
    COMMANDS.forEach((String propertyName, String id) {
      if (!_commands.containsKey(id)) {
        print('[DEBUG] Default command with id="$id" isn\'t available!');
      }
    });
  }
}

final CommandManager commandManagerInstance = CommandManager();
