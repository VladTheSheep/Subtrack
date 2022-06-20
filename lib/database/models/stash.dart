import 'package:hive/hive.dart';
import 'package:subtrack/database/models/date.dart';
import 'package:subtrack/utils/uuid.dart';

part 'stash.g.dart';

@HiveType(typeId: 0)
class Stash extends HiveObject {
  Stash({
    this.stashKey = '',
    this.alias = '',
    // this.substance,
    this.source = '',
    this.description = '',
    this.created,
    this.amount = 0.0,
    this.multiplier = 1.0,
    this.totalUsed = 0.0,
    this.archived = false,
    this.archiveDate,
    this.lastUsed = '',
    this.entryKeys,
    this.substanceName,
  }) {
    if (stashKey == '') stashKey = generateUuid();
    entryKeys ??= [];
  }

  factory Stash.fromJson(Map<String, dynamic> json) => Stash(
        stashKey: json["key"] as String,
        alias: json["alias"] as String?,
        // substance: json["substance"],
        source: json["source"] as String?,
        description: json["description"] as String,
        created: json["created"] is Date ? json["created"] as Date? : Date.fromJson(json["created"] as Map<String, dynamic>),
        amount: json["amount"] as double,
        multiplier: json["multiplier"] as double,
        totalUsed: json["totalUsed"] as double,
        lastUsed: json["lastUsed"] as String?,
        archived: json["archived"] as bool,
        archiveDate: json["archiveDate"] is Date ? json["archiveDate"] as Date : Date.fromJson(json["archiveDate"] as Map<String, dynamic>?),
        entryKeys: json["entryKeys"] as List<dynamic>?,
        substanceName: json["substanceName"] as String?,
      );

  factory Stash.fromInput(Map<String, dynamic> map) => Stash(
        // substanceName: map["Substance"].content,
        alias: map["Alias"].content as String?,
        source: map["Source"].content as String?,
        amount: double.parse(map["Amount"].content as String),
        multiplier: double.parse(map["Count"].content as String),
        description: map["Description"].content as String,
      );

  factory Stash.copyFrom(Stash target) {
    final Stash stash = Stash();
    stash.updateFrom(target);
    return stash;
  }

  @HiveField(0)
  String stashKey;
  @HiveField(1)
  String? alias;
  // @HiveField(2)
  // Substance substance;
  @HiveField(3)
  String? source;
  @HiveField(4)
  String description;
  @HiveField(5)
  Date? created;
  @HiveField(6)
  double amount;
  @HiveField(7)
  double multiplier;
  @HiveField(8)
  double totalUsed;
  @HiveField(9)
  bool archived;
  @HiveField(10)
  Date? archiveDate;
  @HiveField(11)
  String? lastUsed;
  @HiveField(12)
  List<dynamic>? entryKeys;
  @HiveField(13)
  String? substanceName;

  int? substanceKey;

  Map<String, dynamic> toJson() => {
        "key": stashKey,
        "alias": alias,
        // "substance": substance,
        "source": source,
        "description": description,
        "created": created,
        "amount": amount,
        "multiplier": multiplier,
        "totalUsed": totalUsed,
        "lastUsed": lastUsed,
        "archived": archived,
        "archiveDate": archiveDate,
        "entryKeys": entryKeys,
        "substanceName": substanceName,
      };

  void updateFrom(Stash target) {
    alias = target.alias;
    source = target.source;
    amount = target.amount;
    multiplier = target.multiplier;
    description = target.description;
    stashKey = target.stashKey;
    substanceKey = target.substanceKey;
    substanceName = target.substanceName;

    totalUsed = target.totalUsed;
    lastUsed = target.lastUsed;
    archiveDate = target.archiveDate;
    archived = target.archived;
    created = target.created;
    entryKeys = target.entryKeys;
  }
}
