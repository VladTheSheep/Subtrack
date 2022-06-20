import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:subtrack/consts/colors.dart';

part 'effect_type.g.dart';

@HiveType(typeId: 28)
enum EffectType {
  @HiveField(0)
  positive,
  @HiveField(1)
  neutral,
  @HiveField(2)
  negative,
}

Color getEffectTypeColor(EffectType? type) {
  switch (type) {
    case EffectType.positive:
      return researchColorMat;

    case EffectType.neutral:
      return cannabisColorMat;

    case EffectType.negative:
      return empathogenColorMat;

    default:
      return depressantColorMat;
  }
}

EffectType? toEffectType(String type) {
  final String _type = type.toLowerCase();
  switch (_type) {
    case 'positive':
      return EffectType.positive;

    case 'neutral':
      return EffectType.neutral;

    case 'negative':
      return EffectType.negative;

    default:
      return null;
  }
}

String? effectTypeToString(EffectType type) {
  switch (type) {
    case EffectType.positive:
      return 'Positive';

    case EffectType.neutral:
      return 'Neutral';

    case EffectType.negative:
      return 'Negative';

    default:
      return null;
  }
}
