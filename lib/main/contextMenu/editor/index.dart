import 'package:flutter/services.dart';
import 'menu_items.dart';
import 'spellcheck.dart';

final List<MenuItem> contextItems = [
  insertBefore,
  insertAfter,
  separator,
  cut,
  copy,
  paste,
  separator,
  copyAsMarkdown,
  copyAsHtml,
  pasteAsPlainText,
];

bool isInsideEditor(dynamic params) {
  final bool isEditable = params['isEditable'];
  final String inputFieldType = params['inputFieldType'];
  final dynamic editFlags = params['editFlags'];

  return isEditable && inputFieldType == 'none' && editFlags['canEditRichly'];
}

void showEditorContextMenu(
  dynamic win,
  dynamic event,
  dynamic params,
  bool isSpellcheckerEnabled,
) {
  final bool isEditable = params['isEditable'];
  final bool hasImageContents = params['hasImageContents'];
  final String selectionText = params['selectionText'];
  final dynamic editFlags = params['editFlags'];
  final String misspelledWord = params['misspelledWord'];
  final List<String> dictionarySuggestions = params['dictionarySuggestions'];

  if (isInsideEditor(params) && !hasImageContents) {
    final bool hasText = selectionText.trim().length > 0;
    final bool canCopy = hasText && editFlags['canCut'] && editFlags['canCopy'];
    final bool isMisspelled =
        isEditable && selectionText.isNotEmpty && misspelledWord.isNotEmpty;

    final List<MenuItem> menuItems = [];
    if (isSpellcheckerEnabled) {
      final List<MenuItem> spellingSubmenu = spellcheckMenuBuilder(
          isMisspelled, misspelledWord, dictionarySuggestions);
      menuItems.add(MenuItem(
        label: 'Spelling...',
        submenu: spellingSubmenu,
      ));
      menuItems.add(MenuItem(separator));
    }

    cut.enabled = canCopy;
    copy.enabled = canCopy;
    copyAsHtml.enabled = canCopy;
    copyAsMarkdown.enabled = canCopy;

    menuItems.addAll(contextItems);

    // Implement the appropriate Flutter menu logic to show the context menu at the given position.
    // Note: You'll need to create MenuItem and related classes in Flutter, as Electron's menu system isn't directly compatible with Flutter.
  }
}
