import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:imperium/consts/colors.dart';
import 'package:imperium/utils/themes.dart';

part 'effect_category.g.dart';

@HiveType(typeId: 26)
enum EffectCategory {
  @HiveField(0)
  Visual,
  @HiveField(1)
  Cognitive,
  @HiveField(2)
  Physical,
  @HiveField(3)
  Auditory,
  @HiveField(4)
  Disconnective,
  @HiveField(5)
  Tactile,
  @HiveField(6)
  SmellTaste,
  @HiveField(7)
  Multisensory,
}

String getEffectCategorySvgPath(EffectCategory? category) {
  switch (category) {
    case EffectCategory.Visual:
      return 'assets/icons/visual.svg';

    case EffectCategory.Auditory:
      return 'assets/icons/auditory.svg';

    case EffectCategory.Cognitive:
      return 'assets/icons/cognitive.svg';

    case EffectCategory.Disconnective:
      return 'assets/icons/disconnective.svg';

    case EffectCategory.Multisensory:
      return 'assets/icons/multisensory.svg';

    case EffectCategory.Physical:
      return 'assets/icons/physical.svg';

    case EffectCategory.SmellTaste:
      return 'assets/icons/smelltaste.svg';

    case EffectCategory.Tactile:
      return 'assets/icons/tactile.svg';

    default:
      return 'assets/icons/unknown.svg';
  }
}

Color getEffectCategoryColor(EffectCategory category) {
  switch (category) {
    case EffectCategory.Visual:
      return psychColorMat;

    case EffectCategory.Auditory:
      return habitColorMat;

    case EffectCategory.Cognitive:
      return empathogenColorMat;

    case EffectCategory.Disconnective:
      return dissoColorMat;

    case EffectCategory.Multisensory:
      return nootropicColorMat;

    case EffectCategory.Physical:
      return stimColorMat;

    case EffectCategory.SmellTaste:
      return depressantColorMat;

    case EffectCategory.Tactile:
      return researchColorMat;

    default:
      return Themes().getTheme().colorScheme.secondary;
  }
}

String? effectCategoryToString(EffectCategory? category) {
  switch (category) {
    case EffectCategory.Visual:
      return 'Visual';

    case EffectCategory.Cognitive:
      return 'Cognitive';

    case EffectCategory.Physical:
      return 'Physical';

    case EffectCategory.Auditory:
      return 'Auditory';

    case EffectCategory.Disconnective:
      return 'Disconnective';

    case EffectCategory.Tactile:
      return 'Tactile';

    case EffectCategory.SmellTaste:
      return 'Smell and taste';

    case EffectCategory.Multisensory:
      return 'Multisensory';

    default:
      return null;
  }
}

EffectCategory? toEffectCategory(String input) {
  final String _input = input.toLowerCase();
  switch (_input) {
    case 'visual':
      return EffectCategory.Visual;

    case 'cognitive':
      return EffectCategory.Cognitive;

    case 'physical':
      return EffectCategory.Physical;

    case 'auditory':
      return EffectCategory.Auditory;

    case 'disconnective':
      return EffectCategory.Disconnective;

    case 'tactile':
      return EffectCategory.Tactile;

    case 'smelltaste':
      return EffectCategory.SmellTaste;

    case 'multisensory':
      return EffectCategory.Multisensory;

    default:
      return null;
  }
}
