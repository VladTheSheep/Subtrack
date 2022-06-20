import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:subtrack/application/cache_notifier.dart';
import 'package:subtrack/data/imported_database.dart';
import 'package:subtrack/database/hive_utils.dart';
import 'package:subtrack/database/log.dart';
import 'package:subtrack/database/models/entry.dart';
import 'package:subtrack/database/models/note.dart';
import 'package:subtrack/database/models/stash.dart';
import 'package:subtrack/database/models/substance_extra.dart';
import 'package:subtrack/managers/diary_manager.dart';
import 'package:subtrack/managers/stash_manager.dart';
import 'package:subtrack/managers/substance_manager.dart';
import 'package:subtrack/utils/settings.dart';

part 'log_notifier.freezed.dart';

@freezed
class LogNotifierState with _$LogNotifierState {
  const factory LogNotifierState.initial() = _Initial;
  const factory LogNotifierState.error(String errorText) = _ErrorText;
  const factory LogNotifierState.loadingCache() = _LoadingCache;
  const factory LogNotifierState.loadingLog() = _LoadingLog;
  const factory LogNotifierState.loaded() = _Loaded;
}

class LogNotifier extends StateNotifier<LogNotifierState> {
  LogNotifier(
    this._cacheNotifier,
  ) : super(const LogNotifierState.initial());

  final CacheNotifier _cacheNotifier;

  Future<void> createLog({ImportedDatabase? import}) async {
    try {
      await HiveUtils().initHive();
      await loadCache();
      await loadLog(import: import);
    } catch (err) {
      state = LogNotifierState.error("Error occurred while creating log - $err");
    }
  }

  Future<void> loadCache() async {
    state = const LogNotifierState.loadingCache();
    await _cacheNotifier.loadCache();
  }

  Future<LogNotifierState> loadLog({ImportedDatabase? import}) async {
    try {
      await HiveUtils().initHive();

      final List<Entry> entries = Log().getAllEntries;
      final List<Stash> stashes = Log().getAllStashes;
      final List<Note> notes = Log().getAllNotes;
      final List<SubstanceExtra> extra = Log().getAllExtra;

      if (import != null) {
        await Log().addFromImport(import);
      }

      DiaryManager().loadDiaryData(entries);
      DiaryManager().loadNotes(notes);

      await SubstanceManager().setLastUsedROAs(extra);
      await SubstanceManager().setLastUsedSubstances(entries);

      StashManager().loadStashData(stashes);

      Settings().data.setHasCompletedSetup(true);
      return state = const LogNotifierState.loaded();
    } catch (err) {
      state = LogNotifierState.error("Error occurred while loading the log - $err");
      rethrow;
    }
  }
}
