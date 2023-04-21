import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

Map<String, dynamic> getImageInfo(Image image) {
  final paragraph = findNearestParagraph(image);
  final raw = image.getAttribute('data-raw');
  final offset = getOffsetOfParagraph(image, paragraph);
  final tokens = tokenizer(raw);
  final token = tokens[0];
  token['range'] = {
    'start': offset,
    'end': offset + raw.length,
  };
  return {
    'key': paragraph.id,
    'token': token,
    'imageId': image.id,
  };
}

String correctImageSrc(String src) {
  if (src != null) {
    if (path.isAbsolute(src)) {
      src = 'file://' + src;
    }
  }
  return src;
}

// The functions findNearestParagraph, getOffsetOfParagraph, and tokenizer
// need to be implemented in Dart, as they are not provided in the given code.
