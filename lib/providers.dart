import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subtrack/application/cache_notifier.dart';
import 'package:subtrack/application/log_notifier.dart';
import 'package:subtrack/application/navbar_notifier.dart';
import 'package:subtrack/application/permissions_notifier.dart';
import 'package:subtrack/infrastructure/category_repository.dart';
import 'package:subtrack/infrastructure/substance_repository.dart';
import 'package:subtrack/utils/settings.dart';
import 'package:subtrack/utils/themes.dart';

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

final createLogNotifierProvider = StateNotifierProvider<LogNotifier, LogNotifierState>(
  (ref) => LogNotifier(
    ref.watch(cacheNotifierProvider.notifier),
  ),
);

final storagePermissionsNotifierProvider = StateNotifierProvider<PermissionsNotifier, PermissionsNotifierState>(
  (ref) => PermissionsNotifier(),
);

final navBarNotifierProvider = StateNotifierProvider<NavBarNotifier, NavBarNotifierState>(
  (ref) => NavBarNotifier(),
);

final navBarStateNotifierProvider = StateProvider<int>((ref) {
  final NavBarNotifierState state = ref.watch(navBarNotifierProvider);

  if (Settings().data.wokeMode) {
    return state.maybeWhen(
      diary: () => 0,
      stash: () => 1,
      database: () => 2,
      stats: () => 3,
      orElse: () => throw Exception("Out of range"),
    );
  } else {
    return state.maybeWhen(
      diary: () => 0,
      database: () => 1,
      stats: () => 2,
      orElse: () => throw Exception("Out of range"),
    );
  }
});
