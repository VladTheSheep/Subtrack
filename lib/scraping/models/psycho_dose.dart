import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:subtrack/scraping/models/data/psycho_dose_data.dart';

part 'psycho_dose.g.dart';

@JsonSerializable()
@HiveType(typeId: 19)
class PsychoDose {
  PsychoDose({
    this.unit,
    this.threshold,
    this.light,
    this.common,
    this.strong,
    this.heavy,
  });

  factory PsychoDose.fromJson(Map<String, dynamic> json) {
    final PsychoDose result = _$PsychoDoseFromJson(json);
    return result;
  }

  @HiveField(0)
  String? unit;
  @HiveField(1)
  double? threshold;
  @HiveField(2)
  PsychoDoseData? light;
  @HiveField(3)
  PsychoDoseData? common;
  @HiveField(4)
  PsychoDoseData? strong;
  @HiveField(5)
  double? heavy;

  Map<String, dynamic> toJson() => _$PsychoDoseToJson(this);
}
