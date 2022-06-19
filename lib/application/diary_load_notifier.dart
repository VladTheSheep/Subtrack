import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imperium/data/imported_database.dart';
import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/entry.dart';
import 'package:imperium/database/models/note.dart';
import 'package:imperium/database/models/stash.dart';
import 'package:imperium/database/models/substance_extra.dart';
import 'package:imperium/managers/diary_manager.dart';
import 'package:imperium/managers/stash_manager.dart';
import 'package:imperium/managers/substance_manager.dart';

part 'diary_load_notifier.freezed.dart';

@freezed
class DiaryLoadNotifierState with _$DiaryLoadNotifierState {
  const factory DiaryLoadNotifierState.initial() = _Initial;
  const factory DiaryLoadNotifierState.error(String errorText) = _ErrorText;
  const factory DiaryLoadNotifierState.loading() = _Loading;
  const factory DiaryLoadNotifierState.loaded() = _Loaded;
}

class DiaryLoadNotifier extends StateNotifier<DiaryLoadNotifierState> {
  DiaryLoadNotifier() : super(const DiaryLoadNotifierState.initial());

  Future<void> loadLog({ImportedDatabase? import}) async {
    try {
      state = const DiaryLoadNotifierState.loading();

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

      state = const DiaryLoadNotifierState.loaded();
    } catch (_) {
      state = const DiaryLoadNotifierState.error("Error occurred while loading the log");
      rethrow;
    }
  }
}