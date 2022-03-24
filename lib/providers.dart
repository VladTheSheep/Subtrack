import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imperium/application/cache_notifier.dart';
import 'package:imperium/application/create_log_notifier.dart';
import 'package:imperium/application/diary_load_notifier.dart';
import 'package:imperium/infrastructure/category_repository.dart';
import 'package:imperium/infrastructure/substance_repository.dart';
import 'package:imperium/utils/themes.dart';

final themeProvider = StateProvider((ref) => Themes().getTheme());
final settingsProvider = StateProvider((ref) => null);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(),
);

final substanceRepositoryProvider = Provider<SubstanceRepository>(
  (ref) => SubstanceRepository(),
);

final cacheNotifierProvider = StateNotifierProvider(
  (ref) => CacheNotifier(
    ref.watch(categoryRepositoryProvider),
    ref.watch(substanceRepositoryProvider),
  ),
);

final diaryLoadNotifierProvider = StateNotifierProvider(
  (ref) => DiaryLoadNotifier(),
);

final createLogNotifierProvider = StateNotifierProvider<CreateLogNotifier, CreateLogNotifierState>(
  (ref) => CreateLogNotifier(
    ref.watch(cacheNotifierProvider.notifier),
    ref.watch(diaryLoadNotifierProvider.notifier),
  ),
);
