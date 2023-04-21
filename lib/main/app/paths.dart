import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppPaths {
  late String _userDataPath;
  late String _logPath;
  late String _globalStorage;
  late String _preferencesPath;
  late String _sessionsPath;

  AppPaths({String? userDataPath}) {
    if (userDataPath == null || userDataPath.isEmpty) {
      // Use default user data path.
      _initUserDataPath();
    } else {
      _userDataPath = userDataPath;
    }

    _logPath = p.join(_userDataPath, 'logs');
    _globalStorage = p.join(_userDataPath, 'storage');
    _preferencesPath = p.join(_userDataPath, 'preferences');
    _sessionsPath = p.join(_userDataPath, 'sessions');
  }

  Future<void> _initUserDataPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _userDataPath = appDocDir.path;
  }

  String get userDataPath => _userDataPath;
  String get logPath => _logPath;
  String get globalStorage => _globalStorage;
  String get preferencesPath => _preferencesPath;
  String get sessionsPath => _sessionsPath;
}

void ensureAppDirectoriesSync(AppPaths paths) {
  _ensureDirSync(paths.userDataPath);
  _ensureDirSync(paths.logPath);
  _ensureDirSync(paths.globalStorage);
  _ensureDirSync(paths.preferencesPath);
  _ensureDirSync(paths.sessionsPath);
}

void _ensureDirSync(String path) {
  Directory dir = Directory(path);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
}
