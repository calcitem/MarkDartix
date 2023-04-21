import 'dart:io';

final bool isOsx = Platform.isMacOS;
final bool isWindows = Platform.isWindows;
final bool isLinux = Platform.isLinux;

class EditorWinOptions {
  static const Map<String, dynamic> options = {
    'minWidth': 550,
    'minHeight': 350,
    'useContentSize': true,
    'show': true,
    'frame': false,
    'titleBarStyle': 'hiddenInset',
    'zoomFactor': 1.0,
  };
}

class PreferencesWinOptions {
  static const Map<String, dynamic> options = {
    'minWidth': 450,
    'minHeight': 350,
    'width': 950,
    'height': 650,
    'fullscreenable': false,
    'fullscreen': false,
    'minimizable': false,
    'useContentSize': true,
    'show': true,
    'frame': false,
    'thickFrame': !isOsx,
    'titleBarStyle': 'hiddenInset',
    'zoomFactor': 1.0,
  };
}

final List<String> PANDOC_EXTENSIONS = [
  'html',
  'docx',
  'odt',
  'latex',
  'tex',
  'ltx',
  'rst',
  'rest',
  'org',
  'wiki',
  'dokuwiki',
  'textile',
  'opml',
  'epub',
];

final List<String> BLACK_LIST = [
  '\$RECYCLE.BIN',
];

final Map<String, String> EXTENSION_HASN = {
  'styledHtml': '.html',
  'pdf': '.pdf',
};

final int TITLE_BAR_HEIGHT = isOsx ? 21 : 32;
final RegExp LINE_ENDING_REG = RegExp(r'(?:\r\n|\n)');
final RegExp LF_LINE_ENDING_REG = RegExp(r'(?:[^\r]\n)|(?:^\n$)');
final RegExp CRLF_LINE_ENDING_REG = RegExp(r'\r\n');

final String GITHUB_REPO_URL = 'https://github.com/calcitem/markdartix';
final RegExp URL_REG = RegExp(
    r'^http(s)?:\/\/([a-z0-9\-._~]+\.[a-z]{2,}|[0-9.]+|localhost|\[[a-f0-9.:]+\])(:[0-9]{1,5})?(\/[\S]+)?',
    caseSensitive: false);
