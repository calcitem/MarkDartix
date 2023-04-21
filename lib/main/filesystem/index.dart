import 'dart:io';

/// Normalize the path into an absolute path and resolves the link target if needed.
///
/// [pathname] - The path or link path.
/// Returns the absolute path and resolved link. If the link target
/// cannot be resolved, an empty string is returned.
String normalizeAndResolvePath(String pathname) {
  final file = File(pathname);
  if (file.statSync().type == FileSystemEntityType.link) {
    final absPath = file.parent.path;
    final targetPath = File(absPath).resolveSymbolicLinksSync();
    final targetType = File(targetPath).statSync().type;
    if (targetType == FileSystemEntityType.file ||
        targetType == FileSystemEntityType.directory) {
      return File(targetPath).absolute.path;
    }
    print('Cannot resolve link target "$pathname" ($targetPath).');
    return '';
  }
  return File(pathname).absolute.path;
}

Future<void> writeFile(String pathname, String content, String extension,
    {String encoding = 'utf-8'}) async {
  if (pathname == null || pathname.isEmpty) {
    throw ArgumentError('[ERROR] Cannot save file without path.');
  }
  pathname = !extension.isEmpty || pathname.endsWith(extension)
      ? pathname
      : '$pathname$extension';

  final file = File(pathname);
  await file.create(recursive: true);
  await file.writeAsString(content, encoding: Encoding.getByName(encoding));
}
