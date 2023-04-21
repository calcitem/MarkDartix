import 'dart:convert';
import 'dart:io';
import 'package:flutter_string_encodings/flutter_string_encodings.dart';
import 'package:path/path.dart' as path;

final RegExp lineEndingReg = RegExp(r'\r\n|\r|\n');
final RegExp lfLineEndingReg = RegExp(r'\n');
final RegExp crlfLineEndingReg = RegExp(r'\r\n');

bool isMarkdownFile(String filePath) {
  return path.extension(filePath).toLowerCase() == '.md';
}

String getLineEnding(String lineEnding) {
  if (lineEnding == 'lf') {
    return '\n';
  } else if (lineEnding == 'crlf') {
    return '\r\n';
  }

  // This should not happen but use fallback value.
  print(
      'Invalid end of line character: expected "lf" or "crlf" but got "$lineEnding".');
  return '\n';
}

String convertLineEndings(String text, String lineEnding) {
  return text.replaceAll(lineEndingReg, getLineEnding(lineEnding));
}

// This function is based on the `normalizeAndResolvePath` function from the previous answer.
String normalizeMarkdownPath(String pathname) {
  // Add your implementation of `isDirectory2` function from your project.
}

Future<void> writeMarkdownFile(
    String pathname, String content, Map<String, dynamic> options) async {
  String adjustLineEndingOnSave = options['adjustLineEndingOnSave'];
  String lineEnding = options['lineEnding'];
  Map<String, dynamic> encoding = options['encoding'];
  String extension = path.extension(pathname) ?? '.md';

  if (adjustLineEndingOnSave) {
    content = convertLineEndings(content, lineEnding);
  }

  List<int> buffer = Encoding.getByName(encoding['encoding']).encode(content);

  // TODO(@fxha): "safeSaveDocuments" using temporary file and rename syscall.
  // Replace the writeFile function with the implementation from the previous answer.
  await writeFile(pathname, buffer, extension);
}

Future<Map<String, dynamic>> loadMarkdownFile(
    String pathname,
    String preferredEol,
    bool autoGuessEncoding,
    int trimTrailingNewline) async {
  // TODO: Use streams to not buffer the file multiple times and only guess
  //       encoding on the first 256/512 bytes.

  File file = File(path.normalize(pathname));
  List<int> buffer = await file.readAsBytes();

  // Add your implementation of `guessEncoding` function from your project.

  String encoding = guessEncoding(buffer, autoGuessEncoding);
  String markdown = Encoding.getByName(encoding).decode(buffer);

  // Detect line ending
  bool isLf = lfLineEndingReg.hasMatch(markdown);
  bool isCrlf = crlfLineEndingReg.hasMatch(markdown);
  bool isMixedLineEndings = isLf && isCrlf;
  bool isUnknownEnding = !isLf && !isCrlf;
  String lineEnding = preferredEol;
  if (isLf && !isCrlf) {
    lineEnding = 'lf';
  } else if (isCrlf && !isLf) {
    lineEnding = 'crlf';
  }

  bool adjustLineEndingOnSave = false;
  if (isMixedLineEndings || isUnknownEnding || lineEnding != 'lf') {
    adjustLineEndingOnSave = lineEnding != 'lf';
    // Convert to LF for internal use.
    markdown = convertLineEndings(markdown, 'lf');
  }

// Detect final newline
  if (trimTrailingNewline == 2) {
    if (markdown.isEmpty) {
// Use default value
      trimTrailingNewline = 3;
    } else {
      int lastIndex = markdown.length - 1;
      if (lastIndex >= 1 &&
          markdown[lastIndex] == '\n' &&
          markdown[lastIndex - 1] == '\n') {
// Disabled
        trimTrailingNewline = 2;
      } else if (markdown[lastIndex] == '\n') {
// Ensure single trailing newline
        trimTrailingNewline = 1;
      } else {
// Trim trailing newlines
        trimTrailingNewline = 0;
      }
    }
  }

  String filename = path.basename(pathname);
  return {
// document information
    'markdown': markdown,
    'filename': filename,
    'pathname': pathname,

// options
    'encoding': encoding,
    'lineEnding': lineEnding,
    'adjustLineEndingOnSave': adjustLineEndingOnSave,
    'trimTrailingNewline': trimTrailingNewline,

// raw file information
    'isMixedLineEndings': isMixedLineEndings
  };
}
