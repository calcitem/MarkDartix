import 'edit.dart';
import 'file.dart';
import 'format.dart';
import 'markdartix.dart';
import 'paragraph.dart';
import 'view.dart';
import 'window.dart';

void loadMenuCommands(CommandManager commandManager) {
  loadEditCommands(commandManager);
  loadFileCommands(commandManager);
  loadFormatCommands(commandManager);
  loadMarkdartixCommands(commandManager);
  loadParagraphCommands(commandManager);
  loadViewCommands(commandManager);
  loadWindowCommands(commandManager);
}
