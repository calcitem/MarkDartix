import 'dart:convert';
import 'package:path_provider/path_provider.dart';

const String ID_PREFIX = 'mt-';
int id = 0;

String getUniqueId() {
  return '${ID_PREFIX}${id++}';
}

// TODO: Remove this function and load the recommended title from the editor (renderer) when
// requesting the document to save/export.
String getRecommendTitleFromMarkdownString(String markdown) {
  // NOTE: We should read the title from the renderer cache because this regex matches in
  // code blocks too.
  final RegExp regex = RegExp(r'#{1,6} {1,}(.*\S.*)(?:\n|$)');
  final Iterable<RegExpMatch> tokens = regex.allMatches(markdown);
  if (tokens.isEmpty) return '';
  final List<Map<String, dynamic>> headers = tokens.map((t) {
    final RegExpMatch? matches =
        t.group(0)?.trim().matchAsPrefix(RegExp(r'(#{1,6}) {1,}(.+)'));
    return {
      'level': matches?.group(1)?.length ?? 0,
      'content': (matches?.group(2) ?? '').trim(),
    };
  }).toList();
  headers.sort((a, b) => a['level'] - b['level']);
  return headers[0]['content'];
}

// Returns a special directory path for the requested name.
// NOTE: Do not use "userData" to get the user data path, instead use AppPaths!
Future<String> getPath(String name) async {
  if (name == 'userData') {
    throw Exception('Do not use "getPath" for user data path!');
  }

  switch (name) {
    case 'appData':
      return (await getApplicationDocumentsDirectory()).path;
    default:
      throw Exception('Unsupported directory name: $name');
  }
}

bool hasSameKeys(Map<String, dynamic> a, Map<String, dynamic> b) {
  List<String> aKeys = a.keys.toList()..sort();
  List<String> bKeys = b.keys.toList()..sort();
  return jsonEncode(aKeys) == jsonEncode(bKeys);
}

String getLogLevel() {
  if (!const bool.fromEnvironment('MARKDARTIX_DEBUG_VERBOSE') ||
      const int.fromEnvironment('MARKDARTIX_DEBUG_VERBOSE') <= 0) {
    return const bool.fromEnvironment('dart.vm.product') ? 'debug' : 'info';
  } else if (const int.fromEnvironment('MARKDARTIX_DEBUG_VERBOSE') == 1) {
    return 'verbose';
  } else if (const int.fromEnvironment('MARKDARTIX_DEBUG_VERBOSE') == 2) {
    return 'debug';
  }
  return 'silly'; // >= 3
}
