import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<bool> exists(String path) async {
  try {
    await File(path).stat();
    return true;
  } on FileSystemException {
    return false;
  }
}

void ensureDirSync(String dirPath) async {
  try {
    await Directory(dirPath).create(recursive: true);
  } on FileSystemException catch (e) {
    if (e.osError?.errorCode != 17) {
      // Ignore EEXIST errors (directory already exists)
      rethrow;
    }
  }
}

bool isDirectory(String dirPath) {
  try {
    final stat = FileStat.statSync(dirPath);
    return stat.type == FileSystemEntityType.directory;
  } on FileSystemException {
    return false;
  }
}

bool isDirectory2(String dirPath) {
  try {
    final stat = FileStat.statSync(dirPath);
    if (stat.type == FileSystemEntityType.directory) {
      return true;
    } else if (stat.type == FileSystemEntityType.link) {
      final targetPath = Directory(dirPath).resolveSymbolicLinksSync();
      return isDirectory(targetPath);
    }
    return false;
  } on FileSystemException {
    return false;
  }
}

bool isFile(String filePath) {
  try {
    final stat = FileStat.statSync(filePath);
    return stat.type == FileSystemEntityType.file;
  } on FileSystemException {
    return false;
  }
}

bool isFile2(String filePath) {
  try {
    final stat = FileStat.statSync(filePath);
    if (stat.type == FileSystemEntityType.file) {
      return true;
    } else if (stat.type == FileSystemEntityType.link) {
      final targetPath = File(filePath).resolveSymbolicLinksSync();
      return isFile(targetPath);
    }
    return false;
  } on FileSystemException {
    return false;
  }
}

bool isSymbolicLink(String filePath) {
  try {
    final stat = FileStat.statSync(filePath);
    return stat.type == FileSystemEntityType.link;
  } on FileSystemException {
    return false;
  }
}
