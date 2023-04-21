import 'dart:io' show File, FileSystemEntity, Link, Platform;

const List<String> MARKDOWN_EXTENSIONS = [
  'markdown',
  'mdown',
  'mkdn',
  'md',
  'mkd',
  'mdwn',
  'mdtxt',
  'mdtext',
  'text',
  'txt'
];

const List<String> MARKDOWN_INCLUSIONS = [
  '*.markdown',
  '*.mdown',
  '*.mkdn',
  '*.md',
  '*.mkd',
  '*.mdwn',
  '*.mdtxt',
  '*.mdtext',
  '*.text',
  '*.txt'
];

const List<String> IMAGE_EXTENSIONS = [
  'jpeg',
  'jpg',
  'png',
  'gif',
  'svg',
  'webp'
];

bool hasMarkdownExtension(String filename) {
  if (filename == null || filename is! String) return false;
  return MARKDOWN_EXTENSIONS
      .any((ext) => filename.toLowerCase().endsWith('.$ext'));
}

bool isImageFile(String filepath) {
  final extname = File(filepath).extension;
  return FileSystemEntity.isFileSync(filepath) &&
      IMAGE_EXTENSIONS.any((ext) => extname.toLowerCase() == '.$ext');
}

bool isMarkdownFile(String filepath) {
  if (!FileSystemEntity.isFileSync(filepath)) return false;

  if (Link(filepath).existsSync()) {
    final targetPath = Link(filepath).targetSync();
    return FileSystemEntity.isFileSync(targetPath) &&
        hasMarkdownExtension(targetPath);
  }

  return hasMarkdownExtension(filepath);
}

bool isSamePathSync(String pathA, String pathB, [bool isNormalized = false]) {
  if (pathA == null || pathB == null) return false;
  final a = isNormalized ? pathA : File(pathA).absolute.path;
  final b = isNormalized ? pathB : File(pathB).absolute.path;
  if (a.length != b.length) {
    return false;
  } else if (a == b) {
    return true;
  } else if (a.toLowerCase() == b.toLowerCase()) {
    try {
      final fiA = FileStat.statSync(a);
      final fiB = FileStat.statSync(b);
      return fiA.ino == fiB.ino;
    } catch (_) {
      // Ignore error
    }
  }
  return false;
}

bool isChildOfDirectory(String dir, String child) {
  if (dir == null || child == null) return false;
  final relative = p.relative(child, from: dir);
  return relative != null &&
      !relative.startsWith('..') &&
      !p.isAbsolute(relative);
}

String getResourcesPath() {
  var resPath = Platform.resolvedExecutable;
  if (Platform.environment['NODE_ENV'] == 'development') {
    if (Platform.isMacOS) {
      resPath = p.join(resPath, '../../../../..');
    }
    resPath = p.join(resPath, 'resources');
  }
  return resPath;
}
