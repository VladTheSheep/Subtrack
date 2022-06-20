import 'package:json_annotation/json_annotation.dart';
import 'package:subtrack/scraping/models/psycho_roa.dart';

part 'psycho_substance.g.dart';

@JsonSerializable(includeIfNull: false)
class PsychoSubstance {
  PsychoSubstance({
    this.name,
    this.psychoactive,
    this.roas,
    this.effects,
    this.prettyName,
    this.categories,
    this.links,
    this.aliases,
    this.avoid,
    this.bioavailability,
    this.detection,
    this.halflife,
    this.marquis,
    this.interactions,
    this.sources,
    this.doseNote,
    this.summary,
    this.testkits,
    this.warning,
  }) {
    if (prettyName == null) {
      prettyName = name;
      name = name!.toLowerCase();
    }

    categories ??= [];
  }

  factory PsychoSubstance.fromJson(Map<String, dynamic> json) => _$PsychoSubstanceFromJson(json);

  String? name;
  @JsonKey(name: "pretty_name")
  String? prettyName;
  @JsonKey(name: "class")
  Map<String, dynamic>? psychoactive;
  Map<String, PsychoROA>? roas;
  Map<String, dynamic>? effects;
  Map<String, dynamic>? interactions;
  Map<String, dynamic>? sources;
  List<String>? categories;
  Map<String, dynamic>? links;
  List<String>? aliases;
  String? avoid;
  String? bioavailability;
  String? detection;
  String? halflife;
  String? marquis;
  String? summary;
  String? testkits;
  String? warning;
  @JsonKey(name: "dose_note")
  String? doseNote;

  Map<String, dynamic> toJson() => _$PsychoSubstanceToJson(this);
}
