import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:subtrack/database/models/entry.dart';
import 'package:subtrack/database/models/note.dart';
import 'package:subtrack/database/models/stash.dart';
import 'package:subtrack/database/models/substance_extra.dart';

part 'imported_database.g.dart';

@JsonSerializable()
class ImportedDatabase {
  ImportedDatabase(this.entries, this.stashes, this.notes, this.substanceExtras);

  factory ImportedDatabase.fromRawJson(String json) {
    try {
      final Map<String, dynamic> mapped = jsonDecode(json) as Map<String, dynamic>;
      final ImportedDatabase result = ImportedDatabase.fromJson(mapped);

      if (result.entries == null) {
        throw InvalidJsonException();
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }
  factory ImportedDatabase.fromJson(Map<String, dynamic> json) => _$ImportedDatabaseFromJson(json);

  List<Entry>? entries;
  List<Stash>? stashes;
  List<Note>? notes;
  List<SubstanceExtra>? substanceExtras;

  Map<String, dynamic> toJson() => _$ImportedDatabaseToJson(this);
}

class InvalidJsonException implements Exception {}
