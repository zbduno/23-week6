import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  final String filePath;

  FileStorage(this.filePath);

  //reference the file you will use to store data
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$filePath');
  }

  //returns the correct local path to store files
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //append data to the localfile
  Future<File> writeString(String data) async {
    final file = await _localFile;
    // Append text to the file
    return file.writeAsString(data, mode: FileMode.append);
  }

  //overwrite data to the localfile
  Future<File> writeAll(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }
}
