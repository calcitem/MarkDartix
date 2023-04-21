import 'package:flutter/material.dart';

class ImportDialog extends StatefulWidget {
  @override
  _ImportDialogState createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  bool showImport = false;
  bool isOver = false;

  @override
  Widget build(BuildContext context) {
    return showImport
        ? Dialog(
            child: Container(
              width: 450,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isOver
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).textTheme.bodyText1!.color!,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/import_file.png'),
                              Text('Import or Open'),
                              Text(
                                  'Drop here to get your stuff into MarkDartix'),
                            ],
                          ),
                          DragTarget<String>(
                            onWillAccept: (data) {
                              setState(() {
                                isOver = true;
                              });
                              return true;
                            },
                            onAccept: (data) {
                              setState(() {
                                isOver = false;
                              });
                              handleDrop(data);
                            },
                            onLeave: (data) {
                              setState(() {
                                isOver = false;
                              });
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      fileTypeContainer('.md'),
                      fileTypeContainer('.html'),
                      fileTypeContainer('.docx'),
                      fileTypeContainer('.tex'),
                      fileTypeContainer('.wiki'),
                    ],
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }

  Widget fileTypeContainer(String fileType) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).textTheme.bodyText1!.color!),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Text(
          fileType,
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.headline6!.color),
        ),
      ),
    );
  }

  void handleDrop(String data) {
    // Handle drop event
  }

  void showDialog(bool shouldShow) {
    setState(() {
      showImport = shouldShow;
    });
  }
}
