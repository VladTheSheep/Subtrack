import 'package:hive/hive.dart';

part 'interaction_type.g.dart';

@HiveType(typeId: 13)
enum InteractionType {
  @HiveField(0)
  Caution,
  @HiveField(1)
  Unsafe,
  @HiveField(2)
  Dangerous,
  @HiveField(3)
  Synergy,
  @HiveField(4)
  Decrease,
}
