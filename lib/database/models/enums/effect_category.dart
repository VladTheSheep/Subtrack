import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/utils/themes.dart';

part 'effect_category.g.dart';

@HiveType(typeId: 26)
enum EffectCategory {
  @HiveField(0)
  visual,
  @HiveField(1)
  cognitive,
  @HiveField(2)
  physical,
  @HiveField(3)
  auditory,
  @HiveField(4)
  disconnective,
  @HiveField(5)
  tactile,
  @HiveField(6)
  smellTaste,
  @HiveField(7)
  multisensory,
}

String getEffectCategorySvgPath(EffectCategory? category) {
  switch (category) {
    case EffectCategory.visual:
      return 'assets/icons/visual.svg';

    case EffectCategory.auditory:
      return 'assets/icons/auditory.svg';

    case EffectCategory.cognitive:
      return 'assets/icons/cognitive.svg';

    case EffectCategory.disconnective:
      return 'assets/icons/disconnective.svg';

    case EffectCategory.multisensory:
      return 'assets/icons/multisensory.svg';

    case EffectCategory.physical:
      return 'assets/icons/physical.svg';

    case EffectCategory.smellTaste:
      return 'assets/icons/smelltaste.svg';

    case EffectCategory.tactile:
      return 'assets/icons/tactile.svg';

    default:
      return 'assets/icons/unknown.svg';
  }
}

Color getEffectCategoryColor(EffectCategory category) {
  switch (category) {
    case EffectCategory.visual:
      return psychColorMat;

    case EffectCategory.auditory:
      return habitColorMat;

    case EffectCategory.cognitive:
      return empathogenColorMat;

    case EffectCategory.disconnective:
      return dissoColorMat;

    case EffectCategory.multisensory:
      return nootropicColorMat;

    case EffectCategory.physical:
      return stimColorMat;

    case EffectCategory.smellTaste:
      return depressantColorMat;

    case EffectCategory.tactile:
      return researchColorMat;

    default:
      return Themes().accentColor;
  }
}

String? effectCategoryToString(EffectCategory? category) {
  switch (category) {
    case EffectCategory.visual:
      return 'Visual';

    case EffectCategory.cognitive:
      return 'Cognitive';

    case EffectCategory.physical:
      return 'Physical';

    case EffectCategory.auditory:
      return 'Auditory';

    case EffectCategory.disconnective:
      return 'Disconnective';

    case EffectCategory.tactile:
      return 'Tactile';

    case EffectCategory.smellTaste:
      return 'Smell and taste';

    case EffectCategory.multisensory:
      return 'Multisensory';

    default:
      return null;
  }
}

EffectCategory? toEffectCategory(String input) {
  final String _input = input.toLowerCase();
  switch (_input) {
    case 'visual':
      return EffectCategory.visual;

    case 'cognitive':
      return EffectCategory.cognitive;

    case 'physical':
      return EffectCategory.physical;

    case 'auditory':
      return EffectCategory.auditory;

    case 'disconnective':
      return EffectCategory.disconnective;

    case 'tactile':
      return EffectCategory.tactile;

    case 'smelltaste':
      return EffectCategory.smellTaste;

    case 'multisensory':
      return EffectCategory.multisensory;

    default:
      return null;
  }
}
