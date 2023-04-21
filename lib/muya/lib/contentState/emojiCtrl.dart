import 'package:flutter/material.dart';
// Import your parser library
// import 'parser.dart';

class ContentState {
  // Add the properties and methods needed for your ContentState class

  // Example:
  // final BuildContext context;
  // ContentState({required this.context});

  setEmoji(Map item) {
    String key = cursor['start']['key'];
    int offset = cursor['start']['offset'];
    Map startBlock = getBlock(key);
    String text = startBlock['text'];
    // TODO: Implement tokenizer and generator methods from the parser library
    List tokens = tokenizer(text, options: muya.options);
    int delta = 0;

    Map? findEmojiToken(List tokens, int offset) {
      for (Map token in tokens) {
        int start = token['range']['start'];
        int end = token['range']['end'];
        if (offset >= start && offset <= end) {
          delta = end - offset;
          if (token['children'] != null &&
              token['children'] is List &&
              token['children'].length > 0) {
            return findEmojiToken(token['children'], offset);
          } else {
            return token;
          }
        }
      }
      return null;
    }

    Map? token = findEmojiToken(tokens, offset);
    if (token != null && token['type'] == 'emoji') {
      String emojiText = item['aliases'][0];
      offset += delta + emojiText.length - token['content'].length;
      token['content'] = emojiText;
      token['raw'] = ':$emojiText:';
      startBlock['text'] = generator(tokens);
      cursor = {
        'start': {'key': key, 'offset': offset},
        'end': {'key': key, 'offset': offset}
      };
      // TODO: Implement the partialRender() method
      return partialRender();
    }
  }
}
