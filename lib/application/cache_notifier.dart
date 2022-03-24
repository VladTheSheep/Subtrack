import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imperium/database/models/category.dart';
import 'package:imperium/database/models/substance.dart';
import 'package:imperium/infrastructure/category_repository.dart';
import 'package:imperium/infrastructure/substance_repository.dart';
import 'package:imperium/managers/substance_manager.dart';

part 'cache_notifier.freezed.dart';

@freezed
class CacheNotifierState with _$CacheNotifierState {
  const factory CacheNotifierState.initial() = _Initial;
  const factory CacheNotifierState.error(String errorText) = _ErrorText;
  const factory CacheNotifierState.loading() = _Loading;
  const factory CacheNotifierState.loaded(List<Category> categories, List<Substance> substances) = _Loaded;
}

class CacheNotifier extends StateNotifier<CacheNotifierState> {
  CacheNotifier(
    this._categoryRepository,
    this._substanceRepository,
  ) : super(const CacheNotifierState.initial());

  final CategoryRepository _categoryRepository;
  final SubstanceRepository _substanceRepository;

  Future<void> loadCache() async {
    try {
      state = const CacheNotifierState.loading();

      final List<Category> categories = await _categoryRepository.fetchCategories();
      final List<Substance> substances = await _substanceRepository.fetchSubstances();

      await SubstanceManager().setCategories(categories);
      await SubstanceManager().setSubstances(substances);

      state = CacheNotifierState.loaded(categories, substances);
    } catch (_) {
      state = const CacheNotifierState.error("Error occurred while querying API");
      rethrow;
    }
  }
}
