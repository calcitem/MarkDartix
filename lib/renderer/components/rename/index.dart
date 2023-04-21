import 'package:flutter/material.dart';

class RenameDialog extends StatefulWidget {
  @override
  _RenameDialogState createState() => _RenameDialogState();
}

class _RenameDialogState extends State<RenameDialog> {
  bool _showRename = false;
  String _tempName = '';

  void handleRename() {
    setState(() {
      _showRename = true;
    });
    // Implement focus for input
  }

  void confirm() {
    // Implement renaming functionality
    setState(() {
      _showRename = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showRename
        ? Dialog(
            insetPadding: EdgeInsets.all(0),
            child: Container(
              width: 410,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: _tempName,
                    onChanged: (value) {
                      setState(() {
                        _tempName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter new name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    ),
                    onFieldSubmitted: (value) {
                      confirm();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: confirm,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
