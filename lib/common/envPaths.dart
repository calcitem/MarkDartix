import 'package:path/path.dart' as path;

class EnvPaths {
  final String _electronUserDataPath;
  final String _userDataPath;
  final String _logPath;
  final String _preferencesPath;
  final String _dataCenterPath;
  final String _preferencesFilePath;

  EnvPaths(String userDataPath)
      : assert(userDataPath != null),
        _electronUserDataPath = userDataPath,
        _userDataPath = userDataPath,
        _logPath = path.join(userDataPath, 'logs',
            '${DateTime.now().year}${DateTime.now().month.toString().padLeft(2, '0')}'),
        _preferencesPath = userDataPath,
        _dataCenterPath = userDataPath,
        _preferencesFilePath =
            path.join(userDataPath, 'preferences', 'preference.json');

  String get electronUserDataPath => _electronUserDataPath;

  String get userDataPath => _userDataPath;

  String get logPath => _logPath;

  String get preferencesPath => _preferencesPath;

  String get dataCenterPath => _dataCenterPath;

  String get preferencesFilePath => _preferencesFilePath;
}
