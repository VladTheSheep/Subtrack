import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:subtrack/database/log.dart';
import 'package:subtrack/utils/settings.dart';

class FileManager {
  static final FileManager _fileManager = FileManager._internal();

  factory FileManager() => _fileManager;
  FileManager._internal();

  bool storageDenied = true;
  bool manageStorageDenied = true;
  bool storageGranted = false;

  late String _rootAppDirPath;

  String get getRootAppDirPath => _rootAppDirPath;
  String get getExportPath => '$_rootAppDirPath/Export';
  String get getDatabasePath => '$_rootAppDirPath/Database';
  String get getTempBackupPath => '$_rootAppDirPath/Backup';

  Future<bool> get hasStoragePermission async {
    manageStorageDenied = !await Permission.manageExternalStorage.isGranted;
    storageDenied = !await Permission.storage.isGranted;
    return storageGranted = !storageDenied && !manageStorageDenied;
  }

  Future<void> get requestStoragePermission async {
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();
  }

  Future<bool> pickPath() async {
    if (await hasStoragePermission) {
      final String? result = await FilePicker.platform.getDirectoryPath(dialogTitle: "Create database in specified folder");
      if (result != null) {
        _rootAppDirPath = result;
        await _initRootDirectory();
        return true;
      }
      return false;
    }
    return false;
  }

  Future<void> _initRootDirectory() async {
    if (Platform.isAndroid) {
      await Directory(_rootAppDirPath).create(recursive: true).then((Directory dir) => _rootAppDirPath = dir.path);
    }

    await Directory(getDatabasePath).create(recursive: true);
    await Directory(getExportPath).create(recursive: true);
    await Directory(getTempBackupPath).create(recursive: true);
  }

  Future<String?> pickJson() async {
    if (await hasStoragePermission) {
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

    return null;
  }

  Future<String?> exportJsonTo() async {
    final String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: "Select export path",
      fileName: "subtrack.json",
    );

    if (outputFile != null) {
      return outputFile;
    }

    return null;
  }

  Future<File> getFile({required String path, required String fileName, bool checkExist = true}) async {
    final File file = File("$path/$fileName");
    if (checkExist) {
      final bool exists = await file.exists();
      if (!exists) await file.writeAsString('');
    }

    return file;
  }

  Future<String> readFile({required String path, required String fileName}) async {
    final File file = File("$path/$fileName");
    final bool exists = await file.exists();
    if (!exists) {
      await file.writeAsString("");
    }
    return file.readAsString();
  }

  Future<File?> writeFile(String content, {required String path, required String fileName}) async {
    final File file = await getFile(path: path, fileName: fileName);
    return file.writeAsString(content);
  }

  Future<void> clearCache() async {
    await Log().categories.clear();
    await Settings().data.setCacheStatus(categoryStatus: false);
    await Log().substances.clear();
    await Settings().data.setCacheStatus(substanceStatus: false);
  }
}
