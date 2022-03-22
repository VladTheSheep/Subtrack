import 'package:imperium/database/models/entry.dart';
import 'package:imperium/database/models/note.dart';
import 'package:imperium/database/models/stash.dart';
import 'package:imperium/database/models/substance_extra.dart';
import 'package:json_annotation/json_annotation.dart';

part 'imported_database.g.dart';

@JsonSerializable()
class ImportedDatabase {
  ImportedDatabase(this.entries, this.stashes, this.notes, this.substanceExtras);

  factory ImportedDatabase.fromJson(Map<String, dynamic> json) => _$ImportedDatabaseFromJson(json);

  List<Entry>? entries;
  List<Stash>? stashes;
  List<Note>? notes;
  List<SubstanceExtra>? substanceExtras;

  Map<String, dynamic> toJson() => _$ImportedDatabaseToJson(this);
}
