import 'package:subtrack/data/settings_data.dart';

class Settings {
  static final Settings _settings = Settings._internal();

  factory Settings() => _settings;
  Settings._internal();

  SettingsData data = SettingsData();

  Future<void> readSettings() async {
    // final String content = await FileManager().readFile(
    //   path: FileManager().getRootAppDirPath,
    //   fileName: settingsFileName,
    // );
    // if (content.isEmpty) {
    //   await data.writeSettings();
    // } else {
    //   data = SettingsData.fromJson(jsonDecode(content) as Map<String, dynamic>);
    // }
  }
}
