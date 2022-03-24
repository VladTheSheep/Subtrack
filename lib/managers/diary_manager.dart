import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/entry.dart';
import 'package:imperium/database/models/note.dart';
import 'package:imperium/database/models/substance.dart';
import 'package:imperium/managers/substance_manager.dart';

class DiaryManager {
  static final DiaryManager _diaryManager = DiaryManager._internal();

  factory DiaryManager() => _diaryManager;
  DiaryManager._internal();

  void loadDiaryData(List<Entry> data) {
    for (final Entry entry in data) {
      final Substance? sub = Log().getSubstance(entry.substanceName!);

      if (sub != null) {
        sub.timesUsed++;
      }

      entry.substanceKey = sub!.key as int?;
      entry.stashBoxKey = Log().getStash(entry.stashKey)?.key as int?;
      SubstanceManager().addTriedDrug(entry.getSubstance!);
    }
  }

  void loadNotes(List<Note> data) {
    for (final Note note in data) {
      if (note.entryKey!.isNotEmpty) {
        final Entry? entry = Log().getEntry(note.entryKey);
        if (entry != null) {
          entry.noteKeys!.add(note.noteKey);
        } else {
          print("Warning! DiaryManager::loadNotes: Entry not found");
        }
      }
    }
  }
}
