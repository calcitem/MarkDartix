import 'dart:core';
import 'package:url_launcher/url_launcher.dart';

const String githubRepoUrl = 'https://github.com/your_repo_here';

String createGitHubIssueUrl(String? title, String? msg) {
  final Uri issueUrl = Uri.parse('$githubRepoUrl/issues/new').replace(
    queryParameters: {
      if (title != null) 'title': title,
      if (msg != null) 'body': msg,
    },
  );
  return issueUrl.toString();
}

Future<void> createAndOpenGitHubIssueUrl(String? title, String? msg) async {
  final String url = createGitHubIssueUrl(title, msg);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
