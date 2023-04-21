import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentFilesProjects extends StatefulWidget {
  @override
  _RecentFilesProjectsState createState() => _RecentFilesProjectsState();
}

class _RecentFilesProjectsState extends State<RecentFilesProjects> {
  final String contentIcon = 'assets/icons/undraw_content.svg';

  void newFile() {
    // Implement the newFile functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              contentIcon,
              width: 200,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: newFile,
              child: Text('New File'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
