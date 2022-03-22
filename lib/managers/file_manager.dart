import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManager {
  static final FileManager _fileManager = FileManager._internal();

  factory FileManager() => _fileManager;
  FileManager._internal();

  bool storageDenied = true;

  Future<bool> get hasStoragePermission async {
    storageDenied = !await Permission.storage.request().isGranted;
    return !storageDenied;
  }

  void initPaths() async {
    if (await hasStoragePermission) {}
  }

  Future<String?> pickJson() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["json"],
    );

    if (result != null && result.files.single.path != null) {
      final File file = File(result.files.single.path!);
      return file.readAsString();
    }

    return null;
  }
}
