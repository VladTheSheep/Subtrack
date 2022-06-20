import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:subtrack/data/imported_database.dart';
import 'package:subtrack/database/hive_utils.dart';
import 'package:subtrack/database/models/category.dart';
import 'package:subtrack/database/models/date.dart';
import 'package:subtrack/database/models/entry.dart';
import 'package:subtrack/database/models/note.dart';
import 'package:subtrack/database/models/stash.dart';
import 'package:subtrack/database/models/substance.dart';
import 'package:subtrack/database/models/substance_extra.dart';

class Log {
  static final Log _log = Log._internal();

  factory Log() => _log;
  Log._internal();

  Box<Stash> get stashes => Hive.box('stashes');
  Box<Entry> get entries => Hive.box('entries');
  Box<Note> get notes => Hive.box('notes');
  Box<Substance> get substances => Hive.box('substances');
  Box<SubstanceExtra> get substanceExtras => Hive.box('substanceExtras');
  Box<Category> get categories => Hive.box('categories');

  Stash? getStash(String? key) => stashes.values.firstWhereOrNull((element) => element.stashKey == key);
  Entry? getEntry(String? key) => entries.values.firstWhereOrNull((element) => element.entryKey == key);
  Note? getNote(String? key) => notes.values.firstWhereOrNull((element) => element.noteKey == key);
  SubstanceExtra? getSubstanceExtra(String? key) => HiveUtils().getValueExtra(substanceExtras, key);
  Substance? getSubstance(String name) {
    final String _name = name.toLowerCase();
    final Substance? sub = HiveUtils().getValueByName(substances, _name) as Substance?;

    return sub;
  }

  Category? getCategory(String name) {
    final String _name = name.toLowerCase();
    Category? cat = HiveUtils().getValueByName(categories, _name) as Category?;
    return cat ??= HiveUtils().getValueByName(categories, _name.substring(0, _name.length - 1)) as Category?;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////

  List<Substance> get getAllSubstances => substances.values.toList();
  List<Category?> get getAllCategories => categories.values.toList();

  ///////////////////////////////////////////////////////////////////////////////////////////////

  List<Stash> get getAllStashes => stashes.values.toList();
  List<Stash> get getActiveStashes => stashes.values.where((element) => !element.archived).toList();
  List<Stash> get getArchivedStashes => stashes.values.where((element) => element.archived).toList();

  ///////////////////////////////////////////////////////////////////////////////////////////////

  List<Entry> get getAllEntries => entries.values.toList();

  List<Entry> getAllFromStash(String? stashKey) {
    final List<Entry> res = entries.values.where((element) => element.stashKey == stashKey).toList();
    res.sort((a, b) => a.date! > b.date!);
    return res;
  }

  List<Entry> getAllBySubstance(Substance substance) {
    final List<Entry> _entries =
        entries.values.where((element) => element.getSubstance!.name!.toLowerCase() == substance.name!.toLowerCase()).toList();
    _entries.sort((a, b) => a.date! > b.date!);
    return _entries;
  }

  Map<int, List<Entry>> getEntriesForMonth(Date date, {List<Entry>? entries}) {
    final Map<int, List<Entry>> result = {};
    List<Entry> toPerformOn;
    if (entries != null) {
      toPerformOn = entries;
    } else {
      toPerformOn = getAllEntries;
    }
    for (final entry in toPerformOn) {
      if (isSameMonth(entry.date!, date)) {
        if (result[entry.date!.day] == null) result[entry.date!.day] = [];
        result[entry.date!.day]!.add(entry);
      }
    }

    return result;
  }

  Future<List<Entry>> getEntriesListForMonth(Date date) async {
    final List<Entry> result = [];
    for (final entry in getAllEntries) {
      if (isSameMonth(entry.date!, date)) {
        result.add(entry);
      }
    }
    result.sort((a, b) => a.date! > b.date!);

    return result;
  }

  Future<List<Entry>> getEntriesForDate(Date? date) async {
    final List<Entry> result = [];
    for (final Entry entry in getAllEntries) {
      if (isSameDate(entry.date!, date!)) result.add(entry);
    }

    return result;
  }

  Future<List<Note>> getNotesForDate(Date? date) async {
    final List<Note> result = [];
    for (final entry in getAllNotes) {
      if (isSameDate(entry.date!, date!)) result.add(entry);
    }

    return result;
  }

  Map<int, List<Note>> getNotesForMonth(Date date, {List<Note>? notes}) {
    final Map<int, List<Note>> result = {};
    List<Note> toPerformOn;
    if (notes != null) {
      toPerformOn = notes;
    } else {
      toPerformOn = getAllNotes;
    }
    for (final note in toPerformOn) {
      if (isSameMonth(note.date!, date)) {
        if (result[note.date!.day] == null) result[note.date!.day] = [];
        result[note.date!.day]!.add(note);
      }
    }

    return result;
  }

  Entry? getNewestEntry(List<Entry> entries) {
    if (entries.isNotEmpty) {
      Entry result = Entry();
      result = entries.first;

      for (final Entry entry in entries) {
        if (isBeforeDate(result.date!, entry.date!)) result = entry;
      }

      return result;
    }

    return null;
  }

  Future<Entry?> getOldestEntry(List<Entry?> entries) async {
    if (entries.isNotEmpty) {
      Entry? result = Entry();
      result = entries.first;

      for (final Entry? entry in entries) {
        if (isBeforeDate(entry!.date!, result!.date!)) result = entry;
      }

      return result;
    }

    return null;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////

  List<Note> get getAllNotes => notes.values.toList();
  List<SubstanceExtra> get getAllExtra => substanceExtras.values.toList();

  Future<bool> addFromImport(ImportedDatabase imported) async {
    // await eraseDatabase();
    if (imported.entries != null) {
      await HiveUtils().deleteDatabase();
      await HiveUtils().openBoxes();
      await entries.addAll(imported.entries!);
      await stashes.addAll(imported.stashes!);
      await notes.addAll(imported.notes!);
      await substanceExtras.addAll(imported.substanceExtras!);
      return true;
    }

    return false;
  }
}
