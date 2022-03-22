import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:subtrack/database/models/date.dart';
import 'package:subtrack/providers/theme.dart';
import 'package:subtrack/utils/themes.dart';

part 'settings_data.g.dart';

const settingsFileName = "settings.json";

@JsonSerializable()
class SettingsData {
  SettingsData({
    this.accentColor = "Green",
    this.lastCacheRefresh = "",
    this.autoArchiveStashes = false,
    this.checkInteractions = true,
    this.checkDangerousInteraction = true,
    this.checkCautionInteraction = true,
    this.checkUnsafeInteraction = true,
    this.useBlur = true,
    this.autoRefreshCache = true,
    this.categoryCache = false,
    this.substanceCache = false,
    this.useAltDateFormat = false,
    this.use24hourTime = true,
    this.useFromStash = false,
    this.wokeMode = false,
  });

  factory SettingsData.fromJson(Map<String, dynamic> json) => _$SettingsDataFromJson(json);

  String accentColor = "Green";
  String? lastCacheRefresh = "";
  bool autoArchiveStashes = false;
  bool checkInteractions = true;
  bool checkDangerousInteraction = true;
  bool checkUnsafeInteraction = true;
  bool checkCautionInteraction = true;
  bool useBlur = true;
  bool autoRefreshCache = true;
  bool categoryCache = false;
  bool substanceCache = false;
  bool useAltDateFormat = false;
  bool use24hourTime = true;
  bool useFromStash = false;
  bool wokeMode = false;

  Map<String, dynamic> toJson() => _$SettingsDataToJson(this);

  Date get getLastCacheRefresh => Date.fromString(lastCacheRefresh);

  Future<void> setLastCacheRefresh([Date? date]) async {
    lastCacheRefresh = date != null ? date.getDateAsString(fromUI: false) : "";
    await writeSettings();
  }

  Future<void> setAutoArchive(bool value) async {
    autoArchiveStashes = value;
    await writeSettings("autoArchiveStashes");
  }

  Future<void> setAutoRefreshCache(bool value) async {
    autoRefreshCache = value;
    await writeSettings("autoRefreshCache");
  }

  Future<void> setInteractions(bool value) async {
    checkInteractions = value;
    await writeSettings("checkInteractions");
  }

  Future<void> setDangerousInteractions(bool value) async {
    checkDangerousInteraction = value;
    await writeSettings("dangerousInteractions");
  }

  Future<void> setUnsafeInteractions(bool value) async {
    checkUnsafeInteraction = value;
    await writeSettings("unsafeInteractions");
  }

  Future<void> setCautionInteractions(bool value) async {
    checkCautionInteraction = value;
    await writeSettings("cautionInteractions");
  }

  Future<void> setAccentColor(BuildContext context, WidgetRef ref, String color) async {
    accentColor = color;
    ref.read(themeProvider.state).state = Themes().getTheme();
    await writeSettings("accentColorChange");
  }

  Future<void> setAltDateFormat(bool value) async {
    useAltDateFormat = value;
    await writeSettings("altDateFormat");
  }

  Future<void> set24HourTime(bool value) async {
    use24hourTime = value;
    await writeSettings("24hourTime");
  }

  Future<void> setBlur(bool value) async {
    useBlur = value;
    await writeSettings("useBlur");
  }

  void setFromStash(bool value) {
    useFromStash = value;
    writeSettings("useFromStash");
  }

  void setWokeMode(bool value) {
    wokeMode = value;
    writeSettings('wokeMode');
  }

  Future<void> setCacheStatus({bool? substanceStatus, bool? categoryStatus}) async {
    if (substanceStatus != null) substanceCache = substanceStatus;
    if (categoryStatus != null) categoryCache = categoryStatus;
    await writeSettings();
  }

  bool get isCacheEmpty => !substanceCache && !categoryCache;

  Future<void> writeSettings([String? settingChanged]) async {
    // if (settingChanged != null) Settings.settingsStreamController.add(StreamAction(content: true, identifier: settingChanged));
    // await FileHandler.writeFile(
    //   jsonEncode(this),
    //   path: FileHandler.getAppDirPath,
    //   fileName: settingsFileName,
    // );
  }
}
