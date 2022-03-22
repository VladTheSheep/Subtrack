import 'package:hive/hive.dart';

part 'sub_effect_category.g.dart';

@HiveType(typeId: 27)
enum SubEffectCategory {
  @HiveField(0)
  Enhancements,
  @HiveField(1)
  Suppressions,
  @HiveField(2)
  Distortions,
  @HiveField(3)
  Geometry,
  @HiveField(4)
  Hallucinatory,
  @HiveField(5)
  Novel,
  @HiveField(6)
  Psychological,
  @HiveField(7)
  Transpersonal,
  @HiveField(8)
  Alterations,
  @HiveField(9)
  Cardiovascular,
  @HiveField(10)
  Cerebrovascular,
  @HiveField(11)
  Bodily,
  @HiveField(12)
  Misc
}

String? subEffectCategoryToString(SubEffectCategory category) {
  switch (category) {
    case SubEffectCategory.Enhancements:
      return 'Enhancements';

    case SubEffectCategory.Suppressions:
      return 'Suppressions';

    case SubEffectCategory.Distortions:
      return 'Distortions';

    case SubEffectCategory.Geometry:
      return 'Geometry';

    case SubEffectCategory.Hallucinatory:
      return 'Hallucinatory';

    case SubEffectCategory.Novel:
      return 'Novel';

    case SubEffectCategory.Psychological:
      return 'Psychological';

    case SubEffectCategory.Transpersonal:
      return 'Transpersonal';

    case SubEffectCategory.Alterations:
      return 'Alterations';

    case SubEffectCategory.Cardiovascular:
      return 'Cardiovascular';

    case SubEffectCategory.Cerebrovascular:
      return 'Cerebrovascular';

    case SubEffectCategory.Bodily:
      return 'Bodily';

    case SubEffectCategory.Misc:
      return 'Misc';

    default:
      return null;
  }
}

SubEffectCategory? toSubEffectCategory(String category) {
  final String _category = category.toLowerCase();
  switch (_category) {
    case 'enhancements':
      return SubEffectCategory.Enhancements;

    case 'suppressions':
      return SubEffectCategory.Suppressions;

    case 'distortions':
      return SubEffectCategory.Distortions;

    case 'hallucinatory':
      return SubEffectCategory.Hallucinatory;

    case 'novel':
      return SubEffectCategory.Novel;

    case 'psychological':
      return SubEffectCategory.Psychological;

    case 'transpersonal':
      return SubEffectCategory.Transpersonal;

    case 'alterations':
      return SubEffectCategory.Alterations;

    case 'cardiovascular':
      return SubEffectCategory.Cardiovascular;

    case 'cerebrovascular':
      return SubEffectCategory.Cerebrovascular;

    case 'bodily':
      return SubEffectCategory.Bodily;

    case 'misc':
      return SubEffectCategory.Misc;

    default:
      return null;
  }
}
