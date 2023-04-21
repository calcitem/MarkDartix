import 'dart:io';
import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:license_checker/license_checker.dart';

Future<void> validateLicenses(Iterable<String> dependencies) async {
  for (final dependency in dependencies) {
    final result = await LicenseChecker.checkLicense(dependency);
    if (result.isError) {
      print('Error: Unable to validate the license for $dependency');
    } else {
      print('License for $dependency is valid.');
    }
  }
}
