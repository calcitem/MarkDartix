import 'package:flutter/material.dart';
import 'package:your_package_name/util.dart';
import 'package:your_package_name/bus.dart';
import 'package:your_package_name/notification_service.dart';
import 'package:your_package_name/spellchecker.dart';
import 'package:your_package_name/language_map.dart';

// Command to switch the spellchecker language
class SpellcheckerLanguageCommand {
  SpellcheckerLanguageCommand(this.spellchecker) {
    id = 'spellchecker.switch-language';
    description = 'Spelling: Switch language';
    placeholder = 'Select a language to switch to';
    shortcut = null;
  }

  final SpellChecker spellchecker;
  String id;
  String description;
  String placeholder;
  dynamic shortcut;

  List<Map<String, dynamic>> subcommands = [];
  int subcommandSelectedIndex = -1;

  Future<void> run() async {
    List<String> langs = await SpellChecker.getAvailableDictionaries();
    subcommands = langs.map((lang) {
      return {
        'id': 'spellchecker.switch-language-id-${lang}',
        'description': getLanguageName(lang),
        'value': lang,
      };
    }).toList();
    String currentLanguage = spellchecker.lang;
    subcommandSelectedIndex =
        subcommands.indexWhere((cmd) => cmd['value'] == currentLanguage);
  }

  Future<void> execute() async {
    // Timeout to hide the command palette and then show again to prevent issues.
    await Future.delayed(Duration(milliseconds: 100));
    bus.emit('show-command-palette', this);
  }

  void executeSubcommand(String id) {
    Map<String, dynamic> command =
        subcommands.firstWhere((cmd) => cmd['id'] == id);
    if (spellchecker.isEnabled) {
      bus.emit('switch-spellchecker-language', command['value']);
    } else {
      NotificationService.warning(
        title: 'Spelling',
        message: 'Cannot change language because spellchecker is disabled.',
      );
    }
  }

  void unload() {
    subcommands = [];
  }
}
