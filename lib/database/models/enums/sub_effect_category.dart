import 'package:hive/hive.dart';

part 'sub_effect_category.g.dart';

@HiveType(typeId: 27)
enum SubEffectCategory {
  @HiveField(0)
  enhancements,
  @HiveField(1)
  suppressions,
  @HiveField(2)
  distortions,
  @HiveField(3)
  geometry,
  @HiveField(4)
  hallucinatory,
  @HiveField(5)
  novel,
  @HiveField(6)
  psychological,
  @HiveField(7)
  transpersonal,
  @HiveField(8)
  alterations,
  @HiveField(9)
  cardiovascular,
  @HiveField(10)
  cerebrovascular,
  @HiveField(11)
  bodily,
  @HiveField(12)
  misc
}

String? subEffectCategoryToString(SubEffectCategory category) {
  switch (category) {
    case SubEffectCategory.enhancements:
      return 'Enhancements';

    case SubEffectCategory.suppressions:
      return 'Suppressions';

    case SubEffectCategory.distortions:
      return 'Distortions';

    case SubEffectCategory.geometry:
      return 'Geometry';

    case SubEffectCategory.hallucinatory:
      return 'Hallucinatory';

    case SubEffectCategory.novel:
      return 'Novel';

    case SubEffectCategory.psychological:
      return 'Psychological';

    case SubEffectCategory.transpersonal:
      return 'Transpersonal';

    case SubEffectCategory.alterations:
      return 'Alterations';

    case SubEffectCategory.cardiovascular:
      return 'Cardiovascular';

    case SubEffectCategory.cerebrovascular:
      return 'Cerebrovascular';

    case SubEffectCategory.bodily:
      return 'Bodily';

    case SubEffectCategory.misc:
      return 'Misc';

    default:
      return null;
  }
}

SubEffectCategory? toSubEffectCategory(String category) {
  final String _category = category.toLowerCase();
  switch (_category) {
    case 'enhancements':
      return SubEffectCategory.enhancements;

    case 'suppressions':
      return SubEffectCategory.suppressions;

    case 'distortions':
      return SubEffectCategory.distortions;

    case 'hallucinatory':
      return SubEffectCategory.hallucinatory;

    case 'novel':
      return SubEffectCategory.novel;

    case 'psychological':
      return SubEffectCategory.psychological;

    case 'transpersonal':
      return SubEffectCategory.transpersonal;

    case 'alterations':
      return SubEffectCategory.alterations;

    case 'cardiovascular':
      return SubEffectCategory.cardiovascular;

    case 'cerebrovascular':
      return SubEffectCategory.cerebrovascular;

    case 'bodily':
      return SubEffectCategory.bodily;

    case 'misc':
      return SubEffectCategory.misc;

    default:
      return null;
  }
}
