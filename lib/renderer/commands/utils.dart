import 'dart:io';
import 'package:path/path.dart' as path;

/// Check whether the package is updatable at runtime.
bool isUpdatable() {
  // TODO: If not updatable, allow to check whether there is a new version available.

  // You need to get the 'resourcesPath' equivalent for your Flutter application.
  // Replace 'yourResourcesPath' with the actual path to your resources.
  final String resourcesPath = 'yourResourcesPath';

  final bool resFile = File(path.join(resourcesPath, 'app-update.yml')).existsSync();

  if (!resFile) {
    // No update resource file available.
    return false;
  } else if (Platform.environment['APPIMAGE'] != null) {
    // We are running as AppImage.
    return true;
  } else if (Platform.isWindows && File(path.join(resourcesPath, 'md.ico')).existsSync()) {
    // Windows is a little but tricky. The update resource file is always available and
    // there is no way to check the target type at runtime (electron-builder#4119).
    // As workaround we check whether "md.ico" exists that is only included in the setup.
    return true;
  }

  // Otherwise assume that we cannot perform an auto update (standalone binary, archives,
  // packed for package manager).
  return false;
}
