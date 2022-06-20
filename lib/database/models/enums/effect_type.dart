import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:subtrack/consts/colors.dart';

part 'effect_type.g.dart';

@HiveType(typeId: 28)
enum EffectType {
  @HiveField(0)
  Positive,
  @HiveField(1)
  Neutral,
  @HiveField(2)
  Negative,
}

Color getEffectTypeColor(EffectType? type) {
  switch (type) {
    case EffectType.Positive:
      return researchColorMat;

    case EffectType.Neutral:
      return cannabisColorMat;

    case EffectType.Negative:
      return empathogenColorMat;

    default:
      return depressantColorMat;
  }
}

EffectType? toEffectType(String type) {
  final String _type = type.toLowerCase();
  switch (_type) {
    case 'positive':
      return EffectType.Positive;

    case 'neutral':
      return EffectType.Neutral;

    case 'negative':
      return EffectType.Negative;

    default:
      return null;
  }
}

String? effectTypeToString(EffectType type) {
  switch (type) {
    case EffectType.Positive:
      return 'Positive';

    case EffectType.Neutral:
      return 'Neutral';

    case EffectType.Negative:
      return 'Negative';

    default:
      return null;
  }
}
