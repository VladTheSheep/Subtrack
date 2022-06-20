import 'package:hive/hive.dart';

part 'interaction_type.g.dart';

@HiveType(typeId: 13)
enum InteractionType {
  @HiveField(0)
  caution,
  @HiveField(1)
  unsafe,
  @HiveField(2)
  dangerous,
  @HiveField(3)
  synergy,
  @HiveField(4)
  decrease,
}
