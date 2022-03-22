// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imported_database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImportedDatabase _$ImportedDatabaseFromJson(Map<String, dynamic> json) =>
    ImportedDatabase(
      (json['entries'] as List<dynamic>?)
          ?.map((e) => Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['stashes'] as List<dynamic>?)
          ?.map((e) => Stash.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notes'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['substanceExtras'] as List<dynamic>?)
          ?.map((e) => SubstanceExtra.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImportedDatabaseToJson(ImportedDatabase instance) =>
    <String, dynamic>{
      'entries': instance.entries,
      'stashes': instance.stashes,
      'notes': instance.notes,
      'substanceExtras': instance.substanceExtras,
    };
