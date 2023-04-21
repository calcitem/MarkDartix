import 'package:flutter/material.dart';

class ContentState {
  TextEditingController? controller;
  TextSelection? selection;

  ContentState({this.controller, this.selection});

  void replaceWordInline(
      TextSelection line, TextSelection wordCursor, String replacement,
      {bool setCursor = false}) {
    TextPosition lineStart = line.start;
    TextPosition lineEnd = line.end;
    TextPosition wordStart = wordCursor.start;
    TextPosition wordEnd = wordCursor.end;

    // Validate cursor ranges.
    if (wordStart.offset > wordEnd.offset) {
      throw ArgumentError(
          'Invalid word cursor offset: ${wordStart.offset} should be less ${wordEnd.offset}.');
    } else if (lineStart.offset > lineEnd.offset) {
      throw ArgumentError(
          'Invalid line cursor offset: ${lineStart.offset} should be less ${lineEnd.offset}.');
    } else if (wordStart.offset < lineStart.offset ||
        wordEnd.offset > lineEnd.offset) {
      throw ArgumentError(
          'Cursor mismatch: Expect the same line but got different offsets.');
    } else if (controller!.text.length < wordEnd.offset) {
      throw ArgumentError(
          'Invalid cursor: Replacement length is larger than line length.');
    }

    // Replace word range with replacement.
    controller!.text = controller!.text.substring(0, wordStart.offset) +
        replacement +
        controller!.text.substring(wordEnd.offset);

    // Update cursor
    if (setCursor) {
      TextPosition cursor =
          TextPosition(offset: wordStart.offset + replacement.length);
      line =
          TextSelection(baseOffset: cursor.offset, extentOffset: cursor.offset);
      selection = line;
    }

    // You may need to call setState or another method to update the UI
    // after making changes to the text and cursor.
  }
}
