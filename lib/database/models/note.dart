import 'package:hive/hive.dart';
import 'package:subtrack/database/models/date.dart';
import 'package:subtrack/utils/uuid.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note extends HiveObject {
  Note({
    this.noteKey,
    this.text = '',
    this.entryKey = '',
    this.date,
  }) {
    noteKey ??= generateUuid();
  }

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        noteKey: json["key"] as String?,
        text: json["text"] as String?,
        entryKey: json["entryKey"] as String?,
        date: json["date"] as Date?,
      );

  factory Note.fromInput(Map<String, dynamic> map) => Note(
        text: map["Note"].content as String?,
        date: map["Date"].date as Date?,
      );

  @HiveField(0)
  String? noteKey;
  @HiveField(1)
  String? text;
  @HiveField(2)
  String? entryKey;
  @HiveField(3)
  Date? date;

  Map<String, dynamic> toJson() => {
        "key": noteKey,
        "text": text,
        "entryKey": entryKey,
        "date": date,
      };
}
