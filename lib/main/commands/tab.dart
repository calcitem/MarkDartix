import 'index.dart'; // Import the appropriate Dart file with COMMANDS

void switchToLeftTab(dynamic win) {
  if (win != null && win.webContents != null) {
    win.webContents.send('mt::tabs-cycle-left');
  }
}

void switchToRightTab(dynamic win) {
  if (win != null && win.webContents != null) {
    win.webContents.send('mt::tabs-cycle-right');
  }
}

void switchTabByIndex(dynamic win, int index) {
  if (win != null && win.webContents != null) {
    win.webContents.send('mt::switch-tab-by-index', index);
  }
}

void loadTabCommands(CommandManager commandManager) {
  commandManager.add(COMMANDS['TABS_CYCLE_BACKWARD'], switchToLeftTab);
  commandManager.add(COMMANDS['TABS_CYCLE_FORWARD'], switchToRightTab);
  commandManager.add(COMMANDS['TABS_SWITCH_TO_LEFT'], switchToLeftTab);
  commandManager.add(COMMANDS['TABS_SWITCH_TO_RIGHT'], switchToRightTab);
  commandManager.add(COMMANDS['TABS_SWITCH_TO_FIRST'],
      (dynamic win) => switchTabByIndex(win, 0));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_SECOND'],
      (dynamic win) => switchTabByIndex(win, 1));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_THIRD'],
      (dynamic win) => switchTabByIndex(win, 2));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_FOURTH'],
      (dynamic win) => switchTabByIndex(win, 3));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_FIFTH'],
      (dynamic win) => switchTabByIndex(win, 4));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_SIXTH'],
      (dynamic win) => switchTabByIndex(win, 5));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_SEVENTH'],
      (dynamic win) => switchTabByIndex(win, 6));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_EIGHTH'],
      (dynamic win) => switchTabByIndex(win, 7));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_NINTH'],
      (dynamic win) => switchTabByIndex(win, 8));
  commandManager.add(COMMANDS['TABS_SWITCH_TO_TENTH'],
      (dynamic win) => switchTabByIndex(win, 9));
}
