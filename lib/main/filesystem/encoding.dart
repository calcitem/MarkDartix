import 'dart:typed_data';
import 'package:charset_converter/charset_converter.dart';

const Map<String, String> cedIconvEncodings = {
  'BIG5-CP950': 'big5',
  'KSC': 'euckr',
  'ISO-2022-KR': 'euckr',
  'GB': 'gb2312',
  'ISO_2022_CN': 'gb2312',
  'JIS': 'shiftjis',
  'SJS': 'shiftjis',
  'Unicode': 'utf8',
  'ASCII-7-bit': 'utf8',
  'ASCII': 'utf8',
  'MACINTOSH': 'utf8',
};

const Map<String, List<int>> bomEncodings = {
  'utf8': [0xEF, 0xBB, 0xBF],
  'utf16be': [0xFE, 0xFF],
  'utf16le': [0xFF, 0xFE],
};

bool checkSequence(Uint8List buffer, List<int> sequence) {
  if (buffer.length < sequence.length) {
    return false;
  }
  return sequence
      .asMap()
      .entries
      .every((entry) => entry.value == buffer[entry.key]);
}

/// Guess the encoding from the buffer.
///
/// [buffer] - The buffer to guess the encoding from.
/// [autoGuessEncoding] - Whether to use auto guess encoding.
/// Returns a Map with 'encoding' and 'isBom' keys.
Map<String, dynamic> guessEncoding(Uint8List buffer, bool autoGuessEncoding) {
  bool isBom = false;
  String encoding = 'utf8';

  // Detect UTF8- and UTF16-BOM encodings.
  bomEncodings.forEach((key, value) {
    if (checkSequence(buffer, value)) {
      return {'encoding': key, 'isBom': true};
    }
  });

  // Auto guess encoding, otherwise use UTF8.
  if (autoGuessEncoding) {
    encoding = CharsetConverter.guessEncoding(buffer);
    if (cedIconvEncodings[encoding] != null) {
      encoding = cedIconvEncodings[encoding]!;
    } else {
      encoding = encoding.toLowerCase().replaceAll(RegExp(r'[-_]'), '');
    }
  }
  return {'encoding': encoding, 'isBom': isBom};
}
