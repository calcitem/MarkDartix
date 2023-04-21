import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class DockMenuWidget extends StatefulWidget {
  @override
  _DockMenuWidgetState createState() => _DockMenuWidgetState();
}

class _DockMenuWidgetState extends State<DockMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dock Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await openFile();
              },
              child: const Text('Open...'),
            ),
            ElevatedButton(
              onPressed: () {
                // Clear recent documents functionality is platform-dependent
                // and not directly available in Flutter.
              },
              child: const Text('Clear Recent'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openFile() async {
    final params = OpenFileDialogParams(
      dialogType: OpenFileDialogType.document,
      sourceType: SourceType.data,
    );
    final filePath = await FlutterFileDialog.pickFile(params: params);
    if (filePath != null) {
      // Perform necessary actions with the selected file
    }
  }
}
