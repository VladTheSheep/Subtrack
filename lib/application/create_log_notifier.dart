import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imperium/application/cache_notifier.dart';
import 'package:imperium/application/diary_load_notifier.dart';
import 'package:imperium/data/imported_database.dart';
import 'package:imperium/utils/settings.dart';

part 'create_log_notifier.freezed.dart';

@freezed
class CreateLogNotifierState with _$CreateLogNotifierState {
  const factory CreateLogNotifierState.initial() = _Initial;
  const factory CreateLogNotifierState.error(String errorText) = _ErrorText;
  const factory CreateLogNotifierState.loadingCache() = _LoadingCache;
  const factory CreateLogNotifierState.loadingLog() = _LoadingLog;
  const factory CreateLogNotifierState.loaded() = _Loaded;
}

class CreateLogNotifier extends StateNotifier<CreateLogNotifierState> {
  CreateLogNotifier(
    this._cacheNotifier,
    this._diaryLoadNotifier,
  ) : super(const CreateLogNotifierState.initial());

  final CacheNotifier _cacheNotifier;
  final DiaryLoadNotifier _diaryLoadNotifier;

  Future<void> createLog({ImportedDatabase? import}) async {
    try {
      state = const CreateLogNotifierState.loadingCache();
      await _cacheNotifier.loadCache();

      state = const CreateLogNotifierState.loadingLog();
      await _diaryLoadNotifier.loadLog(import: import);

      Settings().data.setHasCompletedSetup(true);
      state = const CreateLogNotifierState.loaded();
    } catch (_) {
      state = const CreateLogNotifierState.error("Error occurred while creating log");
    }
  }
}
