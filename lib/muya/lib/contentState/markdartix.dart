import 'markdartix/spellchecker.dart' as spellchecker;
import 'selection.dart' as selection;

void markdartixApi(dynamic contentState) {
  contentState.replaceCurrentWordInlineUnsafe =
      (String word, String replacement) {
    Map<String, dynamic> cursorRange = selection.getCursorRange();
    Map<String, dynamic> cursor = {
      'start': cursorRange['start'],
      'end': cursorRange['end']
    };
    cursor['start']['block'] =
        contentState.getBlock(cursorRange['start']['key']);

    if (!spellchecker.validateLineCursor(cursor)) {
      print(
          'Unable to replace word: multiple lines are selected. ${cursor.toString()}');
      return false;
    }

    Map<String, dynamic> startCursor = cursor['start'];
    int lineOffset = startCursor['offset'];
    String text = startCursor['block'].text;
    Map<String, dynamic>? wordInfo = spellchecker.extractWord(text, lineOffset);

    if (wordInfo != null) {
      int left = wordInfo['left'];
      int right = wordInfo['right'];
      String selectedWord = wordInfo['word'];

      if (selectedWord != word) {
        print(
            'Unable to replace word: Chromium selection mismatch (expected "$selectedWord" but found "$word").');
        return false;
      }

      Map<String, dynamic> wordRange =
          spellchecker.offsetToWordCursor(contentState.cursor, left, right);
      contentState.replaceWordInline(cursor, wordRange, replacement, true);
      return true;
    }
    return false;
  };
}
