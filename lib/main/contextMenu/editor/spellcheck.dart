import 'package:flutter/material.dart';

class SpellcheckMenuItem extends StatelessWidget {
  final String label;
  final Function() onTap;

  const SpellcheckMenuItem({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: onTap,
    );
  }
}

List<Widget> buildSpellcheckerMenu(
    bool isMisspelled, String misspelledWord, List<String> wordSuggestions) {
  List<Widget> spellingSubmenu = [];

  spellingSubmenu.add(SpellcheckMenuItem(
    label: 'Change Language...',
    onTap: () {
      // Implement sending message 'mt::spelling-show-switch-language' to the target window
    },
  ));

  if (isMisspelled && misspelledWord.isNotEmpty && wordSuggestions.isNotEmpty) {
    spellingSubmenu.add(SpellcheckMenuItem(
      label: 'Add to Dictionary',
      onTap: () {
        // Implement adding the misspelledWord to the dictionary and updating the target window
      },
    ));

    if (wordSuggestions.isNotEmpty) {
      spellingSubmenu.add(Divider());

      for (final word in wordSuggestions) {
        spellingSubmenu.add(SpellcheckMenuItem(
          label: word,
          onTap: () {
            // Implement sending message 'mt::spelling-replace-misspelling' with the word and its replacement to the target window
          },
        ));
      }
    }
  } else {
    spellingSubmenu.add(SpellcheckMenuItem(
      label: 'Edit Dictionary...',
      onTap: () {
        // Implement opening the settings window for spelling
      },
    ));
  }

  return spellingSubmenu;
}
