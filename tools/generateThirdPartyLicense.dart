import 'dart:io';
import 'package:path/path.dart' as p;

void main() async {
  final rootDir = p.dirname(Platform.script.toFilePath());

  final additionalPackages = {
    'hunspell': {
      'packageName': 'Hunspell',
      'licenses': 'LGPL 2.1',
      'licenseText': await File(p.join(rootDir, 'resources',
              'hunspell_dictionaries', 'LICENSE-hunspell.txt'))
          .readAsString(),
    }
  };

  // Implement getLicenses function here
  getLicenses(rootDir, (packages) {
    packages.addAll(additionalPackages);

    String summary = '';
    String licenseList = '';
    int index = 1;
    final addedKeys = <String, int>{};
    for (final key in packages.keys) {
      if (key.startsWith('babel-helper-vue-jsx-merge-props') ||
          key.startsWith('markdartix')) {
        continue;
      }

      final nameRegex = RegExp(r'(^.+)(?:@)').firstMatch(key);
      String packageName = key;
      if (nameRegex != null && nameRegex.group(1) != null) {
        packageName = nameRegex.group(1)!;
      }

      if (addedKeys.containsKey(packageName)) {
        continue;
      }
      addedKeys[packageName] = 1;

      final licenses = packages[key]['licenses'];
      final licenseText = packages[key]['licenseText'];
      summary += '${index++}. $packageName ($licenses)\n';
      licenseList += '# $packageName ($licenses)\n'
          '-------------------------------------------------\n\n'
          '$licenseText\n\n';
    }

    final output = '# Third Party Notices\n'
        '-------------------------------------------------\n\n'
        'This file contains all third-party packages that are bundled and shipped with MarkDartix.\n\n'
        '-------------------------------------------------\n'
        '# Summary\n'
        '-------------------------------------------------\n\n'
        '$summary\n\n'
        '-------------------------------------------------\n'
        '# Licenses\n'
        '-------------------------------------------------\n\n'
        '$licenseList';

    File(p.join(rootDir, 'resources', 'THIRD-PARTY-LICENSES.txt'))
        .writeAsStringSync(output);
  });
}

void getLicenses(
    String rootDir, Function(Map<String, dynamic> packages) callback) {
  // Implement the license fetching logic here and call the callback function.
  // For example, you can use the `pubspec_yaml` and `license_checker` packages as shown in the previous response.
}
