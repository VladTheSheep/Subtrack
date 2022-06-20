import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:subtrack/database/models/enums/effect_category.dart';
import 'package:subtrack/database/models/enums/effect_type.dart';
import 'package:subtrack/database/models/enums/sub_effect_category.dart';
import 'package:subtrack/utils/string_manipulation.dart';

part 'effect.g.dart';

@HiveType(typeId: 24)
@JsonSerializable()
class Effect extends HiveObject {
  Effect({this.name, this.category, this.subCategory, this.type, this.url});
  factory Effect.fromJson(Map<String, dynamic> json) => _$EffectFromJson(json);

  @HiveField(0)
  String? name;
  @HiveField(1)
  EffectCategory? category;
  @HiveField(2)
  SubEffectCategory? subCategory;
  @HiveField(3)
  EffectType? type;
  @HiveField(4)
  String? url;

  Map<String, dynamic> toJson() => _$EffectToJson(this);

  String get getPrettyName => firstCharUppercase(name!);
}
