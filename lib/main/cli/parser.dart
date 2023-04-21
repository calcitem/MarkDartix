import 'dart:io';
import 'package:args/args.dart';

ArgResults parseArgs(List<String> argv, {bool permissive = true}) {
  argv ??= Platform.executableArguments;
  final parser = ArgParser(allowTrailingOptions: permissive);

  parser
    ..addFlag('debug', help: 'Enable debug mode')
    ..addFlag('safe', help: 'Disable plugins and other user configuration')
    ..addFlag('new-window',
        abbr: 'n', help: 'Open a new window on second-instance')
    ..addFlag('disable-gpu', help: 'Disable GPU hardware acceleration')
    ..addFlag('disable-spellcheck', help: 'Disable built-in spellchecker')
    ..addOption('user-data-dir', help: 'Change the user data directory')
    ..addFlag('help', abbr: 'h', help: 'Print this help message')
    ..addOption('verbose',
        abbr: 'v',
        help: 'Be verbose',
        defaultsTo: '0',
        callback: (v) => int.tryParse(v) ?? 0)
    ..addFlag('version', help: 'Print version information');

  return parser.parse(argv);
}
