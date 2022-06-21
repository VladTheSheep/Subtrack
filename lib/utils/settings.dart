import 'dart:convert';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:subtrack/consts/strings.dart';
import 'package:subtrack/data/settings_data.dart';
import 'package:subtrack/managers/file_manager.dart';

class Settings {
  static final Settings _settings = Settings._internal();

  factory Settings() => _settings;
  Settings._internal();

  SettingsData data = SettingsData();
  late PackageInfo packageInfo;

  Future<void> initSettings() async => packageInfo = await PackageInfo.fromPlatform();

  Future<void> readSettings() async {
    final String content = await FileManager().readFile(
      path: FileManager().getAppDocDirPath,
      fileName: settingsFileName,
    );
    if (content.isEmpty) {
      await data.writeSettings();
    } else {
      data = SettingsData.fromJson(jsonDecode(content) as Map<String, dynamic>);
      if (data.databasePath != null) {
        FileManager().rootAppDirPath = data.databasePath!;
      }
    }
  }
}
