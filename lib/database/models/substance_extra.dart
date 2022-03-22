import 'package:hive/hive.dart';
import 'package:imperium/scraping/models/psycho_roa.dart';

part 'substance_extra.g.dart';

@HiveType(typeId: 4)
class SubstanceExtra extends HiveObject {
  SubstanceExtra({
    this.roaKey,
    this.name,
    this.lastROA,
  });

  factory SubstanceExtra.fromJson(Map<String, dynamic> json) => SubstanceExtra(
        roaKey: json["key"] as String?,
        name: json["name"] as String?,
        lastROA: json["lastROA"] is PsychoROA ? json["lastROA"] as PsychoROA : PsychoROA.fromJson(json["lastROA"] as Map<String, dynamic>),
      );

  @HiveField(0)
  String? name;
  @HiveField(1)
  String? _oldLastROA;
  @HiveField(2)
  String? roaKey;
  @HiveField(3)
  PsychoROA? lastROA;

  Map<String, dynamic> toJson() => {
        "key": roaKey,
        "name": name,
        "lastROA": lastROA,
      };
}
