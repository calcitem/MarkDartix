import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/args.dart';

class CliArguments {
  final bool help;
  final bool version;
  final bool debug;
  final bool safe;
  final bool newWindow;
  final String? userDataDir;
  final bool disableGpu;
  final bool disableSpellcheck;
  final bool verbose;

  CliArguments({
    required this.help,
    required this.version,
    required this.debug,
    required this.safe,
    required this.newWindow,
    this.userDataDir,
    required this.disableGpu,
    required this.disableSpellcheck,
    required this.verbose,
  });
}

CliArguments parseCliArguments(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag('help',
        abbr: 'h', help: 'Print this help message', negatable: false)
    ..addFlag('version', help: 'Print version information', negatable: false)
    ..addFlag('debug', help: 'Enable debug mode', negatable: false)
    ..addFlag('safe',
        help: 'Disable plugins and other user configuration', negatable: false)
    ..addFlag('new-window',
        abbr: 'n',
        help: 'Open a new window on second-instance',
        negatable: false)
    ..addOption('user-data-dir', help: 'Change the user data directory')
    ..addFlag('disable-gpu',
        help: 'Disable GPU hardware acceleration', negatable: false)
    ..addFlag('disable-spellcheck',
        help: 'Disable built-in spellchecker', negatable: false)
    ..addFlag('verbose', abbr: 'v', help: 'Be verbose', negatable: false);

  final results = parser.parse(arguments);

  return CliArguments(
    help: results['help'] as bool,
    version: results['version'] as bool,
    debug: results['debug'] as bool,
    safe: results['safe'] as bool,
    newWindow: results['new-window'] as bool,
    userDataDir: results['user-data-dir'] as String?,
    disableGpu: results['disable-gpu'] as bool,
    disableSpellcheck: results['disable-spellcheck'] as bool,
    verbose: results['verbose'] as bool,
  );
}

void main(List<String> arguments) {
  final args = parseCliArguments(arguments);

  if (args.help) {
    print('Usage: your_app [commands] [path ...]');
    print('');
    print('  Available commands:');
    print('');
    print('        --debug                   Enable debug mode');
    print(
        '        --safe                    Disable plugins and other user configuration');
    print(
        '    -n, --new-window              Open a new window on second-instance');
    print('        --user-data-dir           Change the user data directory');
    print(
        '        --disable-gpu             Disable GPU hardware acceleration');
    print('        --disable-spellcheck      Disable built-in spellchecker');
    print('    -v, --verbose                 Be verbose');
    print('        --version                 Print version information');
    print('    -h, --help                    Print this help message');
    exit(0);
  }

  if (args.version) {
    // Replace the following strings with the actual version information of your app and dependencies.
    print('YourApp: 1.0.0');
    print('Dart: ${Platform.version}');
    print('Flutter: X.X.X');
    print('OS: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}');
    exit(0);
  }

// Check for portable mode and ensure the user data path is absolute.
  String? userDataPath;
  if (args.userDataDir != null) {
    userDataPath = p.absolute(args.userDataDir!);
  } else {
    final portablePath =
        p.join(Platform.script.path, '..', '..', 'your_app_user_data');
    if (Directory(portablePath).existsSync()) {
      userDataPath = portablePath;
    }
  }

// The following is an example of how to use the parsed arguments in your Flutter app.
// runApp(YourApp(args));

// To handle the remaining command line arguments, such as opening files, you may need to use
// platform-specific code and/or plugins to interact with the operating system.
}
