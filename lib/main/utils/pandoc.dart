import 'dart:convert';
import 'dart:io';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:process_run/process_run.dart';
import 'package:process_run/shell.dart';

const String pandocCommand = 'pandoc';

String getCommand() {
  if (envPathExists()) {
    return Platform.environment['MARKDARTIX_PANDOC']!;
  }
  return pandocCommand;
}

class Pandoc {
  final String from;
  final String to;
  final List<String> args;

  Pandoc(this.from, this.to, {List<String>? additionalArgs})
      : args = additionalArgs ?? <String>[];

  Future<String> converter() async {
    final String command = getCommand();
    final List<String> option = ['-s', from, '-t', to]..addAll(args);

    try {
      final ProcessResult result = await run(command, option);
      return result.stdout.toString();
    } catch (e) {
      throw Exception('Pandoc conversion failed: $e');
    }
  }

  static Future<bool> exists() async {
    if (envPathExists()) {
      return true;
    }
    try {
      await which(pandocCommand);
      return true;
    } catch (e) {
      return false;
    }
  }
}

bool envPathExists() {
  final String? pandocPath = Platform.environment['MARKDARTIX_PANDOC'];
  if (pandocPath == null) {
    return false;
  }
  final FileSystem fileSystem = LocalFileSystem();
  return fileSystem.file(pandocPath).existsSync();
}
