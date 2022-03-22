import 'package:subtrack/data/settings_data.dart';

class Settings {
  static final Settings _settings = Settings._internal();

  factory Settings() => _settings;
  Settings._internal();

  SettingsData data = SettingsData();
}
