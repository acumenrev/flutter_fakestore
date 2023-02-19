import 'dart:io';

class FSCoreUtils {
  /// Load JSON file to a string
  static Future<String> loadJsonFile(String path) async {
    File dataFile = File(path);
    return await dataFile.readAsString();
  }
}
