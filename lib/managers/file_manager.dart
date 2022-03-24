import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:imperium/database/log.dart';
import 'package:imperium/utils/settings.dart';
import 'package:imperium/utils/string_manipulation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManager {
  static final FileManager _fileManager = FileManager._internal();

  factory FileManager() => _fileManager;
  FileManager._internal();

  bool storageDenied = true;

  late String _rootAppDirPath;
  late String _externalDirPath;
  late String _rootDirPath;

  String get getRootAppDirPath => _rootAppDirPath;
  String get getExportPath => Platform.isAndroid ? '$_rootAppDirPath/Export' : _externalDirPath;
  String get getDatabasePath => Platform.isAndroid ? '$_rootAppDirPath/Database' : _externalDirPath;
  String get getTempBackupPath => Platform.isAndroid ? '$_rootAppDirPath/Backup' : _externalDirPath;

  Future<bool> get hasStoragePermission async {
    storageDenied = !await Permission.storage.request().isGranted;
    return !storageDenied;
  }

  Future<void> initPaths() async {
    if (Platform.isLinux || await hasStoragePermission) {
      storageDenied = false;
      await _startInit();
      await _initRootDirectory();
    } else {
      storageDenied = true;
    }
  }

  Future<void> _startInit() async {
    _externalDirPath = await _externalPath;

    String temp = _externalDirPath;
    for (int i = 0; i < 1; ++i) {
      final int index = findCharPos(temp, '/', true);
      if (index != -1) {
        temp = temp.replaceFirst(temp.substring(index), '', index);
      } else {
        print('ERROR!! FileHandler::getRootDirPath: Could not find root directory!');
        break;
      }
    }
    _rootDirPath = temp;
  }

  Future<void> _initRootDirectory() async {
    if (Platform.isAndroid) {
      await Directory(_rootDirPath).create(recursive: true).then((Directory dir) => _rootAppDirPath = dir.path);
    }

    await Directory(getDatabasePath).create(recursive: true);
    await Directory(getExportPath).create(recursive: true);
    await Directory(getTempBackupPath).create(recursive: true);
  }

  Future<String> get _externalPath async {
    String path = "";
    if (Platform.isAndroid) {
      final List<Directory>? directories = await getExternalStorageDirectories();
      if (directories != null && directories.isNotEmpty) {
        path = directories.first.path;
      }
    } else if (Platform.isIOS || Platform.isLinux) {
      final Directory directory = await getApplicationDocumentsDirectory();
      path = directory.path;
    }
    return path;
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

  Future<String?> exportJsonTo() async {
    final String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: "Select export path",
      fileName: "imperium.json",
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
