import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/paths.dart';

int envId = 0;

void patchEnvPath() {
  if (Platform.isMacOS) {
    String pathDelimiter = Platform.pathSeparator;
    String newPath = '/Library/TeX/texbin';
    if (!Platform.environment['PATH'].endsWith(pathDelimiter)) {
      newPath = pathDelimiter + newPath;
    }
    Platform.environment['PATH'] += newPath;
  }
}

class AppEnvironment {
  int _id;
  AppPaths _appPaths;
  bool _debug;
  bool _isDevMode;
  bool _verbose;
  bool _safeMode;
  bool _disableSpellcheck;

  AppEnvironment({
    bool debug = false,
    bool isDevMode = false,
    bool verbose = false,
    bool safeMode = false,
    String? userDataPath,
    bool disableSpellcheck = false,
  }) {
    _id = envId++;
    _appPaths = AppPaths(userDataPath: userDataPath);
    _debug = debug;
    _isDevMode = isDevMode;
    _verbose = verbose;
    _safeMode = safeMode;
    _disableSpellcheck = disableSpellcheck;
  }

  int get id => _id;
  AppPaths get paths => _appPaths;
  bool get debug => _debug;
  bool get isDevMode => _isDevMode;
  bool get verbose => _verbose;
  bool get safeMode => _safeMode;
  bool get disableSpellcheck => _disableSpellcheck;
}

AppEnvironment setupEnvironment(Map<String, dynamic> args) {
  patchEnvPath();

  bool isDevMode = Platform.environment['NODE_ENV'] != 'production';
  bool debug = args['--debug'] ||
      Platform.environment['MARKDARTIX_DEBUG'] != null ||
      isDevMode;
  bool verbose = args['--verbose'] || false;
  bool safeMode = args['--safe'] || false;
  String? userDataPath = args['--user-data-dir'];
  bool disableSpellcheck = args['--disable-spellcheck'] || false;

  AppEnvironment appEnvironment = AppEnvironment(
    debug: debug,
    isDevMode: isDevMode,
    verbose: verbose,
    safeMode: safeMode,
    userDataPath: userDataPath,
    disableSpellcheck: disableSpellcheck,
  );

  ensureAppDirectoriesSync(appEnvironment.paths);

  // Keep these global variables for easier access.
  // NOTE: Flutter doesn't support setting environment variables, so you need to find an alternative way to store these values.
  // global.MARKDARTIX_DEBUG = debug;
  // global.MARKDARTIX_DEBUG_VERBOSE = verbose;
  // global.MARKDARTIX_SAFE_MODE = safeMode;

  return appEnvironment;
}
