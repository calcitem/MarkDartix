import 'dart:async';
import 'package:flutter/material.dart';

// Note: You will need to find alternative libraries or solutions for
// autoUpdater, ipcMain, BrowserWindow, Menu, and isOsx.

bool runningUpdate = false;
// BrowserWindow win; // Find an alternative for BrowserWindow.

/*
void checkUpdates(BrowserWindow browserWindow) {
  if (!runningUpdate) {
    runningUpdate = true;
    win = browserWindow;
    // autoUpdater.checkForUpdates(); // Find an alternative for autoUpdater.
  }
}

void osxHide() {
  // if (isOsx) { // Find an alternative for isOsx.
  //   Menu.sendActionToFirstResponder('hide:'); // Find an alternative for Menu.
  // }
}

void osxHideAll() {
  // if (isOsx) { // Find an alternative for isOsx.
  //   Menu.sendActionToFirstResponder('hideOtherApplications:'); // Find an alternative for Menu.
  // }
}

void osxShowAll() {
  // if (isOsx) { // Find an alternative for isOsx.
  //   Menu.sendActionToFirstResponder('unhideAllApplications:'); // Find an alternative for Menu.
  // }
}
*/

// --- Commands -------------------------------------------------------------

void loadMarkdartixCommands(CommandManager commandManager) {
  /*
  commandManager.add(COMMANDS.MT_HIDE, osxHide);
  commandManager.add(COMMANDS.MT_HIDE_OTHERS, osxHideAll);
  */
}
