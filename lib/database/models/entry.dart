import 'package:hive/hive.dart';
import 'package:subtrack/database/log.dart';
import 'package:subtrack/database/models/date.dart';
import 'package:subtrack/database/models/substance.dart';
import 'package:subtrack/scraping/models/psycho_roa.dart';
import 'package:subtrack/utils/uuid.dart';

part 'entry.g.dart';

@HiveType(typeId: 1)
class Entry extends HiveObject {
  Entry({
    this.entryKey = '',
    this.stashKey = '',
    this.substanceName = '',
    this.roa,
    this.amount = 0.0,
    this.multiplier = 1.0,
    this.externalUser = false,
    this.date,
    this.notes = '',
    // this.shortcutIndex = -1,
    this.noteKeys,
    this.substanceKey,
    this.stashBoxKey,
  }) {
    if (entryKey == '') entryKey = generateUuid();
    noteKeys ??= [];
  }

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        entryKey: json["key"] as String? ?? '',
        stashKey: json["stashKey"] as String? ?? '',
        substanceName: json["substanceName"] as String?,
        roa: json["ROA"] is PsychoROA ? json["ROA"] as PsychoROA : PsychoROA.fromJson(json["ROA"] as Map<String, dynamic>),
        amount: json["amount"] as double?,
        multiplier: json["multiplier"] as double?,
        externalUser: json["externalUser"] as bool?,
        date: json["date"] is Date ? json["date"] as Date : Date.fromJson(json["date"] as Map<String, dynamic>),
        notes: json["notes"] as String,
        // shortcutIndex: json["shortcutIndex"],
        noteKeys: json["noteKeys"] as List<dynamic>?,
        substanceKey: json["substanceKey"] as int?,
        stashBoxKey: json["stashBoxKey"] as int?,
      );

  factory Entry.fromInput(Map<String, dynamic> map) => Entry(
        substanceName: map["Stash"].content as String?,
        stashKey: map["Stash"].key as String? ?? '',
        roa: PsychoROA(name: map["ROA"].content as String?),
        amount: double.parse(map["Amount"].content as String),
        multiplier: double.parse(map["Count"].content as String),
        externalUser: map["externalUser"].alternate as bool?,
        notes: map["Description"].content as String,
        date: map["Date"].date as Date?,
      );

  factory Entry.copyFrom(Entry target) {
    final Entry entry = Entry();
    entry.updateFrom(target);
    return entry;
  }

  @HiveField(0)
  String entryKey;
  @HiveField(1)
  String stashKey;
  @HiveField(2)
  String? substanceName;
  @HiveField(4)
  double? amount;
  @HiveField(5)
  double? multiplier;
  @HiveField(6)
  bool? externalUser;
  @HiveField(7)
  Date? date;
  @HiveField(8)
  String notes;
  // @HiveField(9)
  // int? shortcutIndex;
  @HiveField(10)
  List<dynamic>? noteKeys;
  @HiveField(11)
  PsychoROA? roa;
  @HiveField(12)
  int? substanceKey;
  @HiveField(13)
  int? stashBoxKey;
  Date? oldDate;

  Map<String, dynamic> toJson() => {
        "key": entryKey,
        "stashKey": stashKey,
        "substanceName": substanceName,
        "ROA": roa,
        "amount": amount,
        "multiplier": multiplier,
        "externalUser": externalUser,
        "date": date,
        "notes": notes,
        // "shortcutIndex": shortcutIndex,
        "noteKeys": noteKeys,
        "substanceKey": substanceKey,
        "stashBoxKey": stashBoxKey,
      };

  void updateFrom(Entry target) {
    entryKey = target.entryKey;
    stashKey = target.stashKey;
    substanceName = target.substanceName;
    amount = target.amount;
    multiplier = target.multiplier;
    externalUser = target.externalUser;
    date = target.date;
    notes = target.notes;
    // shortcutIndex = target.shortcutIndex;
    noteKeys = target.noteKeys;
    roa = target.roa;
    substanceKey = target.substanceKey;
    stashBoxKey = target.stashBoxKey;
    oldDate = target.oldDate;
  }

  Substance? get getSubstance {
    try {
      return Log().substances.get(substanceKey);
    } catch (e) {
      print('ERROR!! Entry::getSubstance: Failed to get substance for entry! -- $e');
      return null;
    }
  }
}
