import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imperium/data/imported_database.dart';
import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/entry.dart';
import 'package:imperium/database/models/note.dart';
import 'package:imperium/database/models/stash.dart';
import 'package:imperium/database/models/substance_extra.dart';
import 'package:imperium/managers/cache_manager.dart';
import 'package:imperium/managers/diary_manager.dart';
import 'package:imperium/managers/stash_manager.dart';
import 'package:imperium/managers/substance_manager.dart';
import 'package:imperium/providers/loading.dart';
import 'package:imperium/scraping/models/psycho_roa.dart';

class DatabaseManager {
  static final DatabaseManager _databaseManager = DatabaseManager._internal();

  factory DatabaseManager() => _databaseManager;
  DatabaseManager._internal();

  Future<String?> loadLog(WidgetRef ref, {Map<String, dynamic>? import}) async {
    String? failure;
    final List<Entry> entries = Log().getAllEntries;
    final List<Stash> stashes = Log().getAllStashes;
    final List<Note> notes = Log().getAllNotes;

    if (import != null) {
      await Log().addFromImport(ImportedDatabase.fromJson(import));
    }

    ref.watch(loadingProvider.notifier).state = "Organizing entries...";
    ref.watch(subtitleLoadingProvider.notifier).state = "";

    final String? entryResponse = await DiaryManager().loadDiaryData(entries);
    if (entryResponse != null) {
      failure = entryResponse;
      ref.watch(loadingProvider.notifier).state = "Error while loading entries";
    } else {
      final dynamic roas = await loadSubstancesExtra(Log().getAllExtra);
      if (roas.runtimeType is String) {
        ref.watch(loadFailProvider.notifier).state = FailStates.Entry;
        return null;
      }

      await SubstanceManager().setLastUsedROAs(roas as Map<String, PsychoROA>);
      await SubstanceManager().setLastUsedSubstances();

      ref.watch(loadingProvider.notifier).state = "Loading stash...";

      final String? stashResponse = await StashManager().loadStashData(stashes);
      if (stashResponse != null && !CacheManager().ignoreCacheError) {
        failure = stashResponse;
        ref.watch(loadFailProvider.notifier).state = FailStates.Stash;
      } else {
        ref.watch(loadingProvider.notifier).state = "Finishing up...";
        await DiaryManager().loadNotes(notes);
        ref.watch(loadingProvider.notifier).state = "";
      }
    }

    if (failure != null) {
      ref.watch(loadFailProvider.notifier).state = FailStates.Note;
    } else {
      ref.watch(loadingProvider.notifier).state = "Log loaded successfully";
      ref.watch(loadSuccessProvider.notifier).state = true;
    }
    return failure;
  }

  Future<dynamic> loadSubstancesExtra(List<SubstanceExtra> items) async {
    print('DatabaseManager::loadSubstancesExtra: Getting last used ROAs for the various substances...');
    try {
      final Map<String, PsychoROA> result = <String, PsychoROA>{};
      for (final SubstanceExtra elem in items) {
        result[elem.name!] = elem.lastROA!;
      }
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  Future<ImportedDatabase> importDatabase(File file) async {
    final String fileContent = await file.readAsString();
    final Map<String, dynamic> map = jsonDecode(fileContent) as Map<String, dynamic>;
    return ImportedDatabase.fromJson(map);
  }
}
