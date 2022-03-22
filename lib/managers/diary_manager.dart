import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/entry.dart';
import 'package:imperium/database/models/note.dart';
import 'package:imperium/database/models/substance.dart';
import 'package:imperium/managers/substance_manager.dart';

class DiaryManager {
  static final DiaryManager _hiveUtils = DiaryManager._internal();

  factory DiaryManager() => _hiveUtils;
  DiaryManager._internal();

  Future<String?> loadDiaryData(List<Entry> data) async {
    for (final Entry entry in data) {
      final Substance? sub = Log().getSubstance(entry.substanceName!);

      if (sub != null) {
        sub.timesUsed++;
      }

      entry.substanceKey = sub!.key as int?;
      entry.stashBoxKey = Log().getStash(entry.stashKey)?.key as int?;
      SubstanceManager().addTriedDrug(entry.getSubstance!);
    }

    return null;
  }

  Future<void> loadNotes(List<Note> data) async {
    for (final Note note in data) {
      if (note.entryKey!.isNotEmpty) {
        await Future(() async {
          final Entry? entry = Log().getEntry(note.entryKey);
          if (entry != null) {
            entry.noteKeys!.add(note.noteKey);
          } else {
            print("Warning! DiaryManager::loadNotes: Entry not found");
          }
        });
      }
    }
  }
}
