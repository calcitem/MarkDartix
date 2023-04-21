import 'package:flutter/material.dart';
import '../actions/file.dart' as actions;
import '../actions/markdartix.dart' show userSetting;
import '../../config.dart' show isOsx;

class FileMenu {
  final keybindings;
  final userPreference;
  final recentlyUsedFiles;

  FileMenu(this.keybindings, this.userPreference, this.recentlyUsedFiles);

  Menu build(BuildContext context) {
    final autoSave = userPreference.getAll()['autoSave'];
    final recentlyUsedMenuItems = List<MenuItem>.empty(growable: true);

    for (final item in recentlyUsedFiles) {
      recentlyUsedMenuItems.add(MenuItem(
        child: Text(item),
        onTap: () {
          actions.openFileOrFolder(browserWindow, item);
        },
      ));
    }

    recentlyUsedMenuItems.add(MenuItem(
      type: MenuItemType.separator,
      visible: recentlyUsedFiles.isNotEmpty,
    ));
    recentlyUsedMenuItems.add(MenuItem(
      child: Text('Clear Recently Used'),
      enabled: recentlyUsedFiles.isNotEmpty,
      onTap: () {
        actions.clearRecentlyUsed();
      },
    ));

    final fileMenuItems = List<MenuItem>.empty(growable: true);
    fileMenuItems.add(MenuItem(
      child: Text('New Tab'),
      accelerator: keybindings.getAccelerator('file.new-tab'),
      onTap: () {
        actions.newBlankTab(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      child: Text('New Window'),
      accelerator: keybindings.getAccelerator('file.new-window'),
      onTap: () {
        actions.newEditorWindow();
      },
    ));
    fileMenuItems.add(MenuItem(
      type: MenuItemType.separator,
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Open File...'),
      accelerator: keybindings.getAccelerator('file.open-file'),
      onTap: () {
        actions.openFile(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Open Folder...'),
      accelerator: keybindings.getAccelerator('file.open-folder'),
      onTap: () {
        actions.openFolder(browserWindow);
      },
    ));

    if (!isOsx) {
      fileMenuItems.add(MenuItem(
        child: Text('Open Recent'),
        submenu: recentlyUsedMenuItems,
      ));
    } else {
      fileMenuItems.add(MenuItem(
        role: MenuRole.recentDocuments,
        submenu: [
          MenuItem(
            role: MenuRole.clearRecentDocuments,
          ),
        ],
      ));
    }

    fileMenuItems.add(MenuItem(
      type: MenuItemType.separator,
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Save'),
      accelerator: keybindings.getAccelerator('file.save'),
      onTap: () {
        actions.save(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Save As...'),
      accelerator: keybindings.getAccelerator('file.save-as'),
      onTap: () {
        actions.saveAs(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Auto Save'),
      type: MenuItemType.checkbox,
      checked: autoSave,
      id: 'autoSaveMenuItem',
      onTap: (item) {
        actions.autoSave(item, browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      type: MenuItemType.separator,
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Move To...'),
      accelerator: keybindings.getAccelerator('file.move-file'),
      onTap: () {
        actions.moveTo(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Rename...'),
      accelerator: keybindings.getAccelerator('file.rename-file'),
      onTap: () {
        actions.rename(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      type: MenuItemType.separator,
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Import...'),
      onTap: () {
        actions.importFile(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Export'),
      submenu: [
        MenuItem(
          child: Text('HTML'),
          onTap: () {
            actions.exportFile(browserWindow, 'styledHtml');
          },
        ),
        MenuItem(
          child: Text('PDF'),
          onTap: () {
            actions.exportFile(browserWindow, 'pdf');
          },
        ),
      ],
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Print'),
      accelerator: keybindings.getAccelerator('file.print'),
      onTap: () {
        actions.printDocument(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      type: MenuItemType.separator,
      visible: !isOsx,
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Preferences...'),
      accelerator: keybindings.getAccelerator('file.preferences'),
      visible: !isOsx,
      onTap: () {
        userSetting();
      },
    ));
    fileMenuItems.add(MenuItem(
      type: MenuItemType.separator,
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Close Tab'),
      accelerator: keybindings.getAccelerator('file.close-tab'),
      onTap: () {
        actions.closeTab(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Close Window'),
      accelerator: keybindings.getAccelerator('file.close-window'),
      onTap: () {
        actions.closeWindow(browserWindow);
      },
    ));
    fileMenuItems.add(MenuItem(
      type: MenuItemType.separator,
      visible: !isOsx,
    ));
    fileMenuItems.add(MenuItem(
      child: Text('Quit'),
      accelerator: keybindings.getAccelerator('file.quit'),
      visible: !isOsx,
      onTap: () {
        app.quit();
      },
    ));

    return Menu(
      child: Text('&File'),
      submenu: fileMenuItems,
    );
  }
}
