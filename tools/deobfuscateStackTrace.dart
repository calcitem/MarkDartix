import 'dart:io';
import 'package:args/args.dart';
import 'package:source_maps/source_maps.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(
      'map',
      abbr: 'm',
      help: 'Path to source map',
    );

  final argResults = parser.parse(arguments);

  final mapPath = argResults['map'] as String?;

  if (mapPath == null) {
    print('ERROR: -m is a required argument.\n');
    print('USAGE:\n  dart deobfuscateStackTrace.dart -m <path_to_source_map>');
    exit(1);
  } else if (!FileSystemEntity.isFileSync(mapPath)) {
    print('ERROR: Invalid source map path: "$mapPath".');
    exit(1);
  }

  final smc = SourceMap.fromJson(File(mapPath).readAsStringSync());

  print('Please paste the stack trace and press Ctrl+D to continue:');

  final stackTraceStr = await stdin.transform(SystemEncoding.decoder).join();
  deobfuscateStackTrace(stackTraceStr, smc);
}

void deobfuscateStackTrace(String stackTraceStr, SourceMap smc) {
  final stack = _parseStackTrace(stackTraceStr);
  if (stack.isEmpty) {
    print('Invalid stack trace.');
    return;
  }

  final errorMessage = stackTraceStr
      .split('\n')
      .firstWhere((line) => line.trim().isNotEmpty, orElse: () => '');
  if (errorMessage.isNotEmpty) {
    print(errorMessage);
  }

  for (final entry in stack) {
    final lineNumber = entry['lineNumber'];
    final column = entry['column'];
    final methodName = entry['methodName'];

    if (lineNumber == null || lineNumber < 1) {
      print('    at $methodName');
    } else {
      final pos = smc.spanFor(lineNumber, column);
      if (pos != null && pos.start != null) {
        final file = pos.start!.sourceUrl;
        final line = pos.start!.line;
        final col = pos.start!.column;
        print('    at $methodName ($file:$line:$col)');
      }
    }
  }
}

List<Map<String, dynamic>> _parseStackTrace(String stackTraceStr) {
  final regex = RegExp(r'([^\s]+) \(([^:]+):(\d+):(\d+)\)');
  final matches = regex.allMatches(stackTraceStr);

  return [
    for (final match in matches)
      {
        'methodName': match.group(1),
        'lineNumber': int.tryParse(match.group(3) ?? ''),
        'column': int.tryParse(match.group(4) ?? ''),
      }
  ];
}
