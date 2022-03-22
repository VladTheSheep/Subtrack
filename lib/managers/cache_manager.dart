import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/category.dart';
import 'package:imperium/database/models/date.dart';
import 'package:imperium/database/models/substance.dart';
import 'package:imperium/managers/substance_manager.dart';
import 'package:imperium/providers/loading.dart';
import 'package:imperium/scraping/substance_scraper.dart';
import 'package:imperium/utils/settings.dart';

class CacheManager {
  static final CacheManager _cacheManager = CacheManager._internal();

  factory CacheManager() => _cacheManager;
  CacheManager._internal();

  bool ignoreCacheError = false;
  bool cacheWasEmpty = false;
  bool apiFailed = false;
  bool categoriesFailed = false;

  Future<String?> loadCache(WidgetRef ref, {bool force = false}) async {
    bool shouldRefresh = false;
    bool autoRefresh = false;
    String? failure;
    cacheWasEmpty = Log().substances.isEmpty;

    if (force || Settings().data.isCacheEmpty) {
      await Settings().data.setCacheStatus(
            categoryStatus: false,
            substanceStatus: false,
          );
      shouldRefresh = true;
    } else {
      autoRefresh = _daysSinceRefresh >= 7 && Settings().data.autoRefreshCache;
    }

    if (shouldRefresh) {
      if (autoRefresh) {
        ref.watch(loadingProvider.notifier).state = "Auto-refreshing cache...";
        ref.watch(subtitleLoadingProvider.notifier).state = "Cache was last refresh $_daysSinceRefresh days ago";
        await Future.delayed(const Duration(milliseconds: 2000));
      }

      ref.watch(loadingProvider.notifier).state = "Querying categories API...";
      ref.watch(subtitleLoadingProvider.notifier).state = "Waiting...";

      final bool catResponse = await _handleCategoryCache(shouldRefresh, ref);
      if (!catResponse) {
        failure = "category";
        ref.watch(loadingProvider.notifier).state = "Error while fetching categories";
        _resetProviders(ref, load: false);
      } else {
        Settings().data.setCacheStatus(categoryStatus: catResponse);
        ref.watch(loadingProvider.notifier).state = "Querying substance API...";
        ref.watch(subtitleLoadingProvider.notifier).state = "Waiting...";
      }

      if (failure == null) {
        final String? subResponse = await _handleSubstanceCache(shouldRefresh, ref);

        failure = subResponse;
        Settings().data.setCacheStatus(substanceStatus: subResponse == null);

        if (subResponse != null) {
          ref.watch(loadingProvider.notifier).state = "Error while fetching substances";
          _resetProviders(ref, load: false);
        }
      } else {
        Settings().data.setCacheStatus(categoryStatus: catResponse);
        _resetProviders(ref, load: false);
      }
    }

    if (failure == null && apiFailed && categoriesFailed) {
      failure = "Failed to retrieve data from API";
    }

    if (failure != null && cacheWasEmpty) {
      ref.watch(loadFailProvider.notifier).state = FailStates.Cache;
    } else if (failure != null) {
      ref.watch(loadMinorFailProvider.notifier).state = FailStates.Cache;
    } else {
      ref.watch(loadingProvider.notifier).state = "API request successful";
      ref.watch(loadSuccessProvider.notifier).state = true;
    }

    if (autoRefresh) {
      Settings().data.setLastCacheRefresh(getNow());
    }

    return failure;
  }

  void _resetProviders(WidgetRef ref, {bool sub = true, bool load = true}) {
    if (load) {
      ref.watch(loadingProvider.notifier).state = "";
    }
    if (sub) {
      ref.watch(subtitleLoadingProvider.notifier).state = "";
    }
  }

  int get _daysSinceRefresh => getNumberOfDaysSince(Settings().data.getLastCacheRefresh, getNow());

  Future<bool> _handleCategoryCache(bool query, WidgetRef ref) async {
    try {
      if (query) {
        final String categoryResponse = await SubstanceScraper().getCategoryCache(ref);
        final Map<String?, Category> categories = await SubstanceScraper().parseCategories(categoryResponse);
        if (categories.isEmpty) return false;
        await SubstanceManager().setCategories(categories);
      } else {
        await SubstanceManager().setCategoriesIcon();
      }
    } catch (e) {
      print("ERROR!! DatabaseManager::_handleCategoryCache: $e");
      categoriesFailed = true;
    }

    return true;
  }

  Future<String?> _handleSubstanceCache(bool query, WidgetRef ref) async {
    try {
      if (query) {
        final Map<String, String> substanceResponse = await SubstanceScraper().getSubstanceCache(ref);
        final Map<String, dynamic> substances = await SubstanceScraper().parseSubstance(substanceResponse, ref);

        final List<Substance>? subs = (substances['result'] as List?)?.map((item) => item as Substance).toList();
        apiFailed = substances['api'] as bool;

        if (subs!.isEmpty) return "No substances found; failed to retrieve data from all APIs";
        await SubstanceManager().setSubstances(subs, clearAndUpdate: (cacheWasEmpty && !apiFailed) || apiFailed);
      }
    } catch (e) {
      print("ERROR!! CacheManager::_handleSubstanceCache: $e");
      return e.toString();
    }

    return null;
  }
}
