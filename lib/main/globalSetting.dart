import 'package:flutter/services.dart';

Future<String> loadAsset(String assetName) async {
  return await rootBundle.loadString('assets/$assetName');
}
