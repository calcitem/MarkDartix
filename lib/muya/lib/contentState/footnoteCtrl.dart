import 'package:flutter/material.dart';

class ContentState {
  // Add the properties and methods needed for your ContentState class

  // Example:
  // final BuildContext context;
  // ContentState({required this.context});

  RegExp footnoteReg = RegExp(r'^\[\^([^\^\[\]\s]+?)(?<!\\)\]: ');

  updateFootnote(Map block, Map line) {
    Map start = cursor['start'];
    Map end = cursor['end'];
    String text = line['text'];
    Match match = footnoteReg.firstMatch(text)!;
    String footnoteIdentifier = match.group(1)!;
    Map sectionWrapper = createBlock('figure', {'functionType': 'footnote'});
    Map footnoteInput = createBlock(
        'span', {'text': footnoteIdentifier, 'functionType': 'footnoteInput'});
    Map pBlock = createBlockP(text.substring(match.group(0)!.length));
    appendChild(sectionWrapper, footnoteInput);
    appendChild(sectionWrapper, pBlock);
    insertBefore(sectionWrapper, block);
    removeBlock(block);

    String key = pBlock['children'][0]['key'];
    cursor = {
      'start': {
        'key': key,
        'offset': (start['offset'] - footnoteIdentifier.length)
            .clamp(0, double.infinity)
      },
      'end': {
        'key': key,
        'offset': (end['offset'] - footnoteIdentifier.length)
            .clamp(0, double.infinity)
      }
    };

    if (isCollapse()) {
      checkInlineUpdate(pBlock['children'][0]);
    }

    render();
    return sectionWrapper;
  }

  createFootnote(String identifier) {
    List<Map> blocks = this.blocks;
    Map lastBlock = blocks[blocks.length - 1];
    Map newBlock = createBlockP('[^$identifier]: ');
    insertAfter(newBlock, lastBlock);
    String key = newBlock['children'][0]['key'];
    int offset = newBlock['children'][0]['text'].length;
    cursor = {
      'start': {'key': key, 'offset': offset},
      'end': {'key': key, 'offset': offset}
    };
    Map sectionWrapper = updateFootnote(newBlock, newBlock['children'][0]);
    String id = sectionWrapper['key'];
    // TODO: Implement scrollToFootnote with your custom scroll behavior
    scrollToFootnote(id);
  }

  // Add your custom scroll behavior for footnotes
  void scrollToFootnote(String id) {
    // Example implementation:
    // ScrollController controller = ScrollController();
    // controller.jumpTo(controller.position.maxScrollExtent);
  }
}
