import 'package:execall/execall.dart';

const Map<String, bool> defaultSearchOption = {
  'isCaseSensitive': false,
  'isWholeWord': false,
  'isRegexp': false
};

List<RegExpMatch> matchString(
    String text, String value, Map<String, bool> options) {
  bool isCaseSensitive = options['isCaseSensitive'] ?? false;
  bool isWholeWord = options['isWholeWord'] ?? false;
  bool isRegexp = options['isRegexp'] ?? false;
  RegExp specialCharReg = RegExp(r'[\[\]\\^$.\|\?\*\+\(\)\/]{1}');
  RegExp? searchReg;
  String regStr = value;
  String flag = 'g';

  if (!isCaseSensitive) {
    flag += 'i';
  }

  if (!isRegexp) {
    regStr = value.replaceAllMapped(specialCharReg, (match) {
      return match[0] == '\\' ? '\\\\' : '\\${match[0]}';
    });
  }

  if (isWholeWord) {
    regStr = r'\b' + regStr + r'\b';
  }

  try {
    searchReg = RegExp(regStr, caseSensitive: isCaseSensitive);
    return searchReg.allMatches(text).toList();
  } catch (err) {
    return [];
  }
}

void searchCtrl(dynamic contentState) {
  contentState.buildRegexValue = (RegExpMatch match, String value) {
    RegExp groupsReg = RegExp(r'(?<!\\)\$\d');
    Iterable<RegExpMatch> groups = groupsReg.allMatches(value);

    if (groups.isNotEmpty) {
      for (RegExpMatch group in groups) {
        int index = int.parse(group.group(0)!.replaceFirst(RegExp(r'^\$'), ''));
        if (index == 0) {
          value = value.replaceFirst(group.group(0)!, match.group(0)!);
        } else if (index > 0 && index <= match.groupCount) {
          value = value.replaceFirst(group.group(0)!, match.group(index)!);
        }
      }
    }

    return value;
  };

  contentState.replaceOne = (Map<String, dynamic> match, String value) {
    int start = match['start'];
    int end = match['end'];
    String key = match['key'];
    dynamic block = contentState.getBlock(key);
    String text = block.text;
    block.text = text.substring(0, start) + value + text.substring(end);
  };

  contentState.replace = (String replaceValue, {Map<String, dynamic>? opt}) {
    opt ??= {'isSingle': true};
    bool isSingle = opt['isSingle'] ?? true;
    bool isRegexp = opt['isRegexp'] ?? false;
    Map<String, dynamic> searchOptions = {...defaultSearchOption, ...opt}
      ..remove('isSingle');
    Map<String, dynamic> searchMatches = contentState.searchMatches;
    List<dynamic> matches = searchMatches['matches'];
    String value = searchMatches['value'];
    int index = searchMatches['index'];

    if (matches.isNotEmpty) {
      if (isRegexp) {
        replaceValue =
            contentState.buildRegexValue(matches[index], replaceValue);
      }
      if (isSingle) {
        contentState.replaceOne(matches[index], replaceValue);
      } else {
        for (dynamic match in matches) {
          contentState.replaceOne(match, replaceValue);
        }
      }
      int highlightIndex = index < matches.length - 1 ? index : index - 1;
      contentState.search(value,
          {...searchOptions, 'highlightIndex': isSingle ? highlightIndex : -1});
    }
  };

  contentState.setCursorToHighlight = () {
    Map<String, dynamic> searchMatches = contentState.searchMatches;
    List<dynamic> matches = searchMatches['matches'];
    int index = searchMatches['index'];
    Map<String, dynamic>? match = matches[index];

    if (match == null) return;
    String key = match['key'];
    int start = match['start'];
    int end = match['end'];

    contentState.cursor = {
      'noHistory': true,
      'start': {'key': key, 'offset': start},
      'end': {'key': key, 'offset': end}
    };
  };

  contentState.find = (String action) {
    Map<String, dynamic> searchMatches = contentState.searchMatches;
    List<dynamic> matches = searchMatches['matches'];
    int index = searchMatches['index'];
    int len = matches.length;
    if (len == 0) return;
    index = action == 'next' ? index + 1 : index - 1;
    if (index < 0) index = len - 1;
    if (index >= len) index = 0;
    searchMatches['index'] = index;
    contentState.setCursorToHighlight();
  };

  contentState.search = (String value, {Map<String, dynamic>? opt}) {
    List<dynamic> matches = [];
    opt ??= {};
    Map<String, dynamic> options = {...defaultSearchOption, ...opt};
    int highlightIndex = options['highlightIndex'] ?? -1;
    List<dynamic> blocks = contentState.blocks;

    void travel(List<dynamic> blocks) {
      for (dynamic block in blocks) {
        String? text = block.text;
        String key = block.key;

        if (text != null && text is String) {
          List<RegExpMatch> strMatches = matchString(text, value, options);
          matches.addAll(strMatches.map((match) {
            return {
              'key': key,
              'start': match.start,
              'end': match.end,
              'match': match.group(0),
              'subMatches':
                  match.groups(List.generate(match.groupCount, (i) => i + 1))
            };
          }));
        }
        if (block.children.isNotEmpty) {
          travel(block.children);
        }
      }
    }

    if (value.isNotEmpty) travel(blocks);
    int index = -1;
    if (highlightIndex != -1) {
      index = highlightIndex;
    } else if (matches.isNotEmpty) {
      index = 0;
    }
    contentState.searchMatches = {
      'value': value,
      'matches': matches,
      'index': index
    };
    if (value.isNotEmpty) {
      contentState.setCursorToHighlight();
    }
    return matches;
  };
}
