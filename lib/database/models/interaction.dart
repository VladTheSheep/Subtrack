import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:subtrack/database/models/enums/interaction_type.dart';

part 'interaction.g.dart';

@HiveType(typeId: 14)
@JsonSerializable()
class Interaction {
  Interaction({this.name, this.status, this.note});
  factory Interaction.fromJson(Map<String, dynamic> json) => _$InteractionFromJson(json);

  @HiveField(0)
  String? name;
  @HiveField(1)
  String? altSub;
  @HiveField(2)
  InteractionType? status;
  @HiveField(3)
  String? note;

  Map<String, dynamic> toJson() => _$InteractionToJson(this);

  static InteractionType stringToInteractionType(String input) {
    switch (input.toLowerCase()) {
      case 'caution':
        return InteractionType.caution;

      case 'unsafe':
        return InteractionType.unsafe;

      case 'dangerous':
        return InteractionType.dangerous;

      case 'low risk & synergy':
        return InteractionType.synergy;

      case 'low risk & decrease':
        return InteractionType.decrease;

      default:
        throw 'Invalid string!';
    }
  }
}
