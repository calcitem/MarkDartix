import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_escape/html_escape.dart';

class CodeBlockController {
  String? _selectedLanguage;
  int? _startOffset;
  int? _endOffset;

  Map<String, dynamic> checkEditLanguage(
      TextEditingController controller, TextSelection selection) {
    if (selection.isCollapsed) {
      _startOffset = selection.start;
      _endOffset = selection.end;
    } else {
      return {'lang': '', 'paragraph': null};
    }

    // You may need to adjust this regular expression to match your use case.
    RegExp codeUpdateRegExp = RegExp(r'^`{3,}(.*)');
    Match? match = codeUpdateRegExp.firstMatch(controller.text);

    if (match != null) {
      _selectedLanguage = match.group(1);
    } else {
      _selectedLanguage = '';
    }

    return {'lang': _selectedLanguage, 'paragraph': null};
  }

  void selectLanguage(TextEditingController controller, String lang) {
    // You may need to adjust this function based on your requirements.
    _selectedLanguage = lang;
  }

  void updateCodeLanguage(String lang) {
    // You may need to adjust this function based on your requirements.
    _selectedLanguage = lang;
  }

  bool codeBlockUpdate(String code, {String lang = ''}) {
    // You may need to adjust this function based on your requirements.
    if (lang.isNotEmpty) {
      _selectedLanguage = lang;
      return true;
    }
    return false;
  }

  Future<void> copyCodeBlock(String codeContent) async {
    await Clipboard.setData(ClipboardData(text: codeContent));
  }
}
