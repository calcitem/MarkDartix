import 'package:markdown/markdown.dart';
import '../utils.dart';

// Source: https://github.com/Microsoft/vscode/blob/master/src/vs/editor/common/model/wordHelper.ts
// /(-?\d*\.\d\w*)|([^\`\~\!\@\#\$\%\^\&\*\(\)\-\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/
final wordSeparators =
    RegExp('(?:[`~!@#\$%^&*()-=+[{\]}\\\\|;:\'",.<>\\/?\\s])');
final wordDefinition = RegExp(
    '(?:-?\\d*\\.\\d\\w*)|(?:[^`~!@#\$%^&*()-=+[{\]}\\\\|;:\'",.<>\\/?\\s]+)');

/// Translate a left and right offset from a word in `line` into a cursor with
/// the given line cursor.
///
/// @param {*} lineCursor The original line cursor.
/// @param {number} left Start offset/index of word in `lineCursor`.
/// @param {number} right End offset/index of word in `lineCursor`.
/// @returns {*} Return a cursor of the word selected in `lineCursor`(e.g.
///              "foo >bar< foo" where `>`/`<` start and end offset).
Map<String, dynamic> offsetToWordCursor(
    Map<String, dynamic> lineCursor, int left, int right) {
  // Deep clone cursor start and end
  final start = deepClone(lineCursor['start']);
  final end = deepClone(lineCursor['end']);
  start['offset'] = left;
  end['offset'] = right;
  return {'start': start, 'end': end};
}

/// Validate whether the selection is valid for spelling correction.
///
/// @param {*} selection The preview editor selection range.
bool validateLineCursor(Map<String, dynamic> selection) {
  // Validate selection range.
  if (selection == null ||
      selection['start'] == null ||
      !selection['start'].containsKey('offset') ||
      selection['end'] == null ||
      !selection['end'].containsKey('offset')) {
    return false;
  }

  // Allow only single lines
  final startCursor = selection['start'];
  final endCursor = selection['end'];
  if (startCursor['key'] != endCursor['key'] || !startCursor['block']) {
    return false;
  }

  // Don't correct words in code blocks or editors for HTML, LaTex and diagrams.
  if (startCursor['block']['functionType'] == 'codeContent' &&
      startCursor['block']['lang'] != null) {
    return false;
  }

  // Don't correct words in code blocks or pre elements such as language identifier.
  if (selection.containsKey('affiliation') &&
      selection['affiliation'].length == 1 &&
      selection['affiliation'][0]['type'] == 'pre') {
    return false;
  }
  return true;
}

/// Extract the word at the given offset from the text.
///
/// @param {string} text Text
/// @param {number} offset Normalized cursor offset (e.g. ab<cursor>c def --> 2)
Map<String, dynamic> extractWord(String text, int offset) {
  if (text == null || text.length == 0) {
    return null;
  } else if (offset < 0) {
    offset = 0;
  } else if (offset >= text.length) {
    offset = text.length - 1;
  }
// Matches all words starting at a good position.
  wordDefinition.lastMatch.start = text.lastIndexOf(' ', offset - 1) + 1;
  var match;
  var left = -1;
  while ((match = wordDefinition.firstMatch(text)) != null) {
    if (match != null && match.start <= offset) {
      if (wordDefinition.lastMatch.end > offset) {
        left = match.start;
      }
    } else {
      break;
    }
  }
  wordDefinition.lastMatch.start = 0;

// Cursor is between two word separators (e.g "<cursor>" or " <cursor>*")
  if (left <= -1) {
    return null;
  }

// Find word ending.
  wordSeparators.lastMatch.start = offset;
  match = wordSeparators.firstMatch(text);
  var right = -1;
  if (match != null) {
    right = match.start;
  }
  wordSeparators.lastMatch.start = 0;

// The last word in the string is a special case.
  if (right < 0) {
    return {'left': left, 'right': text.length, 'word': text.substring(left)};
  }
  return {'left': left, 'right': right, 'word': text.substring(left, right)};
}
