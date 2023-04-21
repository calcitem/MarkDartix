import 'package:flutter/material.dart';
import 'package:your_project/config.dart'; // Import the file containing the VOID_HTML_TAGS and HTML_TAGS constants
import 'package:your_project/parser/rules.dart'; // Import the file containing the inlineRules

final RegExp HTML_BLOCK_REG = RegExp(r'^<([a-zA-Z\d-]+)(?=\s|>)[^<>]*?>$');

void htmlBlock(dynamic contentState) {
  contentState.createHtmlBlock = (String code) {
    dynamic block = contentState.createBlock('figure');
    block.functionType = 'html';
    Map<String, dynamic> preAndPreview =
        contentState.createPreAndPreview('html', code);
    contentState.appendChild(block, preAndPreview['preBlock']);
    contentState.appendChild(block, preAndPreview['preview']);
    return block;
  };

  contentState.initHtmlBlock = (dynamic block) {
    String htmlContent = '';
    String text = block.children[0].text;
    RegExpMatch? matches = inlineRules['html_tag'].firstMatch(text);
    if (matches != null) {
      String tag = matches.group(3)!;
      String content = matches.group(4) ?? '';
      String openTag = matches.group(2)!;
      String? closeTag = matches.group(5);
      bool isVoidTag = VOID_HTML_TAGS.contains(tag);
      if (closeTag != null) {
        htmlContent = text;
      } else if (isVoidTag) {
        htmlContent = text;
        if (content.isNotEmpty) {
          print('Invalid html content.');
        }
      } else {
        htmlContent = '$openTag\n$content\n</$tag>';
      }
    } else {
      htmlContent = '<div>\n$text\n</div>';
    }

    block.type = 'figure';
    block.functionType = 'html';
    block.text = htmlContent;
    block.children = [];
    Map<String, dynamic> preAndPreview =
        contentState.createPreAndPreview('html', htmlContent);
    contentState.appendChild(block, preAndPreview['preBlock']);
    contentState.appendChild(block, preAndPreview['preview']);

    return preAndPreview['preBlock'];
  };

  contentState.updateHtmlBlock = (dynamic block) {
    String type = block.type;
    if (type != 'li' && type != 'p') return false;
    String text = block.children[0].text;
    RegExpMatch? match = HTML_BLOCK_REG.firstMatch(text);
    String? tagName = match != null && match.group(1) != null
        ? HTML_TAGS.firstWhere((t) => t == match.group(1), orElse: () => '')
        : null;
    return !VOID_HTML_TAGS.contains(tagName) && tagName != null
        ? contentState.initHtmlBlock(block)
        : false;
  };
}
