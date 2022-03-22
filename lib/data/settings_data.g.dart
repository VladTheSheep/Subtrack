// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsData _$SettingsDataFromJson(Map<String, dynamic> json) => SettingsData(
      accentColor: json['accentColor'] as String? ?? "Green",
      lastCacheRefresh: json['lastCacheRefresh'] as String? ?? "",
      autoArchiveStashes: json['autoArchiveStashes'] as bool? ?? false,
      checkInteractions: json['checkInteractions'] as bool? ?? true,
      checkDangerousInteraction: json['checkDangerousInteraction'] as bool? ?? true,
      checkCautionInteraction: json['checkCautionInteraction'] as bool? ?? true,
      checkUnsafeInteraction: json['checkUnsafeInteraction'] as bool? ?? true,
      useBlur: json['useBlur'] as bool? ?? true,
      autoRefreshCache: json['autoRefreshCache'] as bool? ?? true,
      categoryCache: json['categoryCache'] as bool? ?? false,
      substanceCache: json['substanceCache'] as bool? ?? false,
      useAltDateFormat: json['useAltDateFormat'] as bool? ?? false,
      use24hourTime: json['use24hourTime'] as bool? ?? true,
      useFromStash: json['useFromStash'] as bool? ?? false,
      wokeMode: json['wokeMode'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingsDataToJson(SettingsData instance) => <String, dynamic>{
      'accentColor': instance.accentColor,
      'lastCacheRefresh': instance.lastCacheRefresh,
      'autoArchiveStashes': instance.autoArchiveStashes,
      'checkInteractions': instance.checkInteractions,
      'checkDangerousInteraction': instance.checkDangerousInteraction,
      'checkUnsafeInteraction': instance.checkUnsafeInteraction,
      'checkCautionInteraction': instance.checkCautionInteraction,
      'useBlur': instance.useBlur,
      'autoRefreshCache': instance.autoRefreshCache,
      'categoryCache': instance.categoryCache,
      'substanceCache': instance.substanceCache,
      'useAltDateFormat': instance.useAltDateFormat,
      'use24hourTime': instance.use24hourTime,
      'useFromStash': instance.useFromStash,
      'wokeMode': instance.wokeMode,
    };
