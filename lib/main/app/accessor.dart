import '../app/window_manager.dart';
import '../preferences.dart';
import '../data_center.dart';
import '../keyboard/shortcut_handler.dart';
import '../menu.dart';
import '../menu/actions.dart';
import '../commands.dart';

class Accessor {
  AppEnvironment env;
  Paths paths;
  Preference preferences;
  DataCenter dataCenter;
  CommandManager commandManager;
  Keybindings keybindings;
  AppMenu menu;
  WindowManager windowManager;

  Accessor(AppEnvironment appEnvironment) {
    String userDataPath = appEnvironment.paths.userDataPath;

    this.env = appEnvironment;
    this.paths = appEnvironment.paths;

    this.preferences = Preference(this.paths);
    this.dataCenter = DataCenter(this.paths);

    this.commandManager = CommandManager();
    _loadCommands();

    this.keybindings = Keybindings(this.commandManager, appEnvironment);
    this.menu = AppMenu(this.preferences, this.keybindings, userDataPath);
    this.windowManager = WindowManager(this.menu, this.preferences);
  }

  void _loadCommands() {
    loadDefaultCommands(commandManager);
    loadMenuCommands(commandManager);

    if (this.env.isDevMode) {
      commandManager.verifyDefaultCommands();
    }
  }
}
