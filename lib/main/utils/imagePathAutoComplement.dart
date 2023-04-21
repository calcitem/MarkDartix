import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:fuzzy/fuzzy.dart';

const List<String> imageExtensions = [
  '.png',
  '.jpg',
  '.jpeg',
  '.gif',
  '.bmp',
  '.webp'
];
const List<String> blackList = ['.DS_Store'];

class FileSearch {
  final Map<String, List<Map<String, String>>> imagePath = {};

  List<Map<String, String>> filesHandler(
      List<FileSystemEntity> files, String directory, String? key) {
    RegExp imageReg =
        RegExp('(' + imageExtensions.join('|') + r')$', caseSensitive: false);

    List<Map<String, String>> onlyDirAndImage = files
        .map((file) {
          String type = '';
          if (file is Directory) {
            type = 'directory';
          } else if (file is File && imageReg.hasMatch(file.path)) {
            type = 'image';
          }
          return {
            'file': file.path,
            'type': type,
          };
        })
        .where((item) =>
            !blackList.contains(path.basename(item['file']!)) &&
            (item['type'] == 'directory' || item['type'] == 'image'))
        .toList();

    imagePath[directory] = onlyDirAndImage;

    if (key != null) {
      final options = WeightedItemOptions<Map<String, String>>(
          items: onlyDirAndImage, getter: (item) => item['file']!);
      final search = Fuzzy<Map<String, String>>(options);
      return search.search(key);
    } else {
      return onlyDirAndImage;
    }
  }

  Future<List<Map<String, String>>> searchFilesAndDir(
      String directory, String? key) async {
    List<Map<String, String>> result = [];

    if (imagePath.containsKey(directory)) {
      final options = WeightedItemOptions<Map<String, String>>(
          items: imagePath[directory]!, getter: (item) => item['file']!);
      final search = Fuzzy<Map<String, String>>(options);
      result = search.search(key ?? '');
      return result;
    } else {
      Directory dir = Directory(directory);
      try {
        List<FileSystemEntity> files = await dir.list().toList();
        result = filesHandler(files, directory, key);
        return result;
      } catch (e) {
        throw FileSystemException('Error reading directory: $directory');
      }
    }
  }
}
