import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subtrack/application/cache_notifier.dart';
import 'package:subtrack/application/log_notifier.dart';
import 'package:subtrack/application/permissions_notifier.dart';
import 'package:subtrack/infrastructure/category_repository.dart';
import 'package:subtrack/infrastructure/substance_repository.dart';
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
