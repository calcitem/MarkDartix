import 'dart:io';
import 'package:clipboard/clipboard.dart';

bool hasClipboardFiles() {
  // There's no direct way to check if the clipboard has files in Flutter.
  // You can only check if clipboard data is not empty.
  return FlutterClipboard.getData != null;
}

List<String> getClipboardFiles() {
  if (!hasClipboardFiles()) {
    return [];
  }
  // In Flutter, you cannot access the clipboard files directly.
  // You can only access text, images, and other standard types.
  return [];
}

String guessClipboardFilePath() {
  if (Platform.isLinux) {
    return '';
  } else if (Platform.isMacOS) {
    List<String> result = getClipboardFiles();
    return result.isNotEmpty ? result[0] : '';
  } else if (Platform.isWindows) {
    return FutureBuilder<String>(
      future: FlutterClipboard.paste(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          String rawFilePath = snapshot.data!;
          String filePath = rawFilePath.replaceAll(RegExp('\x00'), '');
          return filePath.isNotEmpty ? filePath : '';
        } else {
          return '';
        }
      },
    );
  } else {
    return '';
  }
}
