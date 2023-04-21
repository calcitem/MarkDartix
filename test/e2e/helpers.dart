import 'dart:io';
import 'package:path/path.dart' as p;

String mainEntrypoint = 'lib/main.dart';

String getDateAsFilename() {
  final date = DateTime.now();
  return '${date.year}${date.month}${date.day}';
}

String getTempPath() {
  final name = 'markdartix-e2etest-$getDateAsFilename()';
  return p.join(Directory.systemTemp.path, name);
}

// In Flutter, this is your `main` function, but you can customize it with user arguments.
// Here's an example of how to pass arguments to your main function:
Future<void> runAppWithArgs(List<String> userArgs) async {
  // Pass the arguments to your main function, runApp, or any other method as needed.
  print('Launching app with arguments: $userArgs');
}
