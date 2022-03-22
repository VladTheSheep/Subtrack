import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imperium/utils/string_manipulation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final pathInitProvider = StateProvider<bool>((ref) => false);

class FileManager {
  static final FileManager _fileManager = FileManager._internal();

  factory FileManager() => _fileManager;
  FileManager._internal();

  bool storageDenied = true;

  String? _appDirPath;
  String? _rootAppDirPath;
  String? _externalDirPath;
  String? _rootDirPath;

  String? get getAppDirPath => Platform.isLinux ? _externalDirPath : _appDirPath;
  String? get getRootAppDirPath => _rootAppDirPath;
  String? get getExportPath => Platform.isAndroid ? '${_rootAppDirPath!}/Export' : _externalDirPath;
  String? get getDatabasePath => Platform.isAndroid ? '${_rootAppDirPath!}/Database' : _externalDirPath;
  String? get getTempBackupPath => Platform.isAndroid ? '${_rootAppDirPath!}/Backup' : _externalDirPath;

  Future<bool> get hasStoragePermission async {
    storageDenied = !await Permission.storage.request().isGranted;
    return !storageDenied;
  }

  void initPaths(WidgetRef ref) {
    hasStoragePermission.then((value) async {
      if (value) {
        storageDenied = false;
        await _startInit();
        await _initRootDirectory();
        ref.watch(pathInitProvider.notifier).state = true;
      } else {
        storageDenied = true;
      }
    });
  }

  Future<void> _startInit() async {
    _appDirPath = await _localPath;
    _externalDirPath = await _externalPath;

    String? temp = _externalDirPath;
    for (int i = 0; i < 1; ++i) {
      final int index = findCharPos(temp, '/', true);
      if (index != -1) {
        temp = temp!.replaceFirst(temp.substring(index), '', index);
      } else {
        print('ERROR!! FileHandler::getRootDirPath: Could not find root directory!');
        break;
      }
    }
    _rootDirPath = temp;
  }

  Future<void> _initRootDirectory() async {
    if (Platform.isAndroid) await Directory(_rootDirPath!).create(recursive: true).then((Directory dir) => _rootAppDirPath = dir.path);

    await Directory(getDatabasePath!).create(recursive: true).then((value) => null);
    await Directory(getExportPath!).create(recursive: true).then((value) => null);
    await Directory(getTempBackupPath!).create(recursive: true).then((value) => null);
  }

  Future<String?> get _externalPath async {
    try {
      if (Platform.isAndroid) {
        final List<Directory>? directories = await getExternalStorageDirectories();
        if (directories != null && directories.isNotEmpty) {
          return directories.first.path;
        }
      } else if (Platform.isIOS || Platform.isLinux) {
        final Directory directory = await getApplicationDocumentsDirectory();
        return directory.path;
      } else {
        print('ERROR!! FileHandler::_externalPath: Invalid platform!');
      }
    } catch (e) {
      print('Error in FileHandler::_externalPath -- $e');
    }
    return null;
  }

  Future<String?> get _localPath async {
    try {
      late Directory directory;

      if (Platform.isAndroid) {
        directory = await getApplicationDocumentsDirectory();
      } else if (Platform.isIOS || Platform.isLinux) {
        directory = await getApplicationSupportDirectory();
      }

      return directory.path;
    } catch (e) {
      print('Error in FileHandler::_localPath -- $e');
      return null;
    }
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
}
