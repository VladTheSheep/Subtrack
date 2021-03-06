import 'package:hive_flutter/adapters.dart';
import 'package:subtrack/database/log.dart';
import 'package:subtrack/database/models/category.dart';
import 'package:subtrack/database/models/date.dart';
import 'package:subtrack/database/models/effect.dart';
import 'package:subtrack/database/models/entry.dart';
import 'package:subtrack/database/models/enums/effect_category.dart';
import 'package:subtrack/database/models/enums/effect_type.dart';
import 'package:subtrack/database/models/enums/interaction_type.dart';
import 'package:subtrack/database/models/enums/sub_effect_category.dart';
import 'package:subtrack/database/models/interaction.dart';
import 'package:subtrack/database/models/note.dart';
import 'package:subtrack/database/models/stash.dart';
import 'package:subtrack/database/models/substance.dart';
import 'package:subtrack/database/models/substance_extra.dart';
import 'package:subtrack/managers/file_manager.dart';
import 'package:subtrack/scraping/models/data/psycho_dose_data.dart';
import 'package:subtrack/scraping/models/data/psycho_duration_data.dart';
import 'package:subtrack/scraping/models/psycho_dose.dart';
import 'package:subtrack/scraping/models/psycho_roa.dart';

class HiveUtils {
  static final HiveUtils _hiveUtils = HiveUtils._internal();

  factory HiveUtils() => _hiveUtils;
  HiveUtils._internal();

  bool _initialized = false;

  Future<void> initHive() async {
    if (!_initialized) {
      await Hive.initFlutter(FileManager().getDatabasePath);
      _initialized = true;
    }
    await openBoxes();
  }

  Future<void> closeBoxes() async {
    await Hive.close();
  }

  Future<bool> openBoxes({List<int>? password, bool debugThrow = false}) async {
    try {
      if (debugThrow) throw HiveError("DEBUG");
      await openBox<Stash>('stashes', password: password);
      await openBox<Entry>('entries', password: password);
      await openBox<Note>('notes', password: password);
      await openBox<SubstanceExtra>('substanceExtras', password: password);

      await openBox<Substance>('substances');
      await openBox<Category>('categories');
    } catch (e) {
      print("ERROR!! HiveUtils::openBoxes: $e");
      await Hive.close();
      return false;
      // throw HiveError(e.toString());
    }

    return true;
  }

  Future<Box<TValue>> openBox<TValue>(String box, {List<int>? password}) async {
    try {
      if (!Hive.isBoxOpen(box)) {
        // print("HiveUtils::openBox: '$box' not open, opening${password != null ? " with password" : ""}...");
        if (password != null) {
          return await Hive.openBox<TValue>(box, crashRecovery: false, encryptionCipher: HiveAesCipher(password));
        } else {
          return await Hive.openBox<TValue>(box, crashRecovery: false);
        }
      } else {
        return Hive.box<TValue>(box);
      }
    } catch (e) {
      print("ERROR! HiveUtils::openBox: Unable to open box!");
      throw HiveError(e.toString());
    }
  }

  void registerAdapters() {
    Hive.registerAdapter(StashAdapter());
    Hive.registerAdapter(EntryAdapter());
    Hive.registerAdapter(SubstanceExtraAdapter());
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(DateAdapter());
    Hive.registerAdapter(SubstanceAdapter());
    Hive.registerAdapter(InteractionTypeAdapter());
    Hive.registerAdapter(InteractionAdapter());
    Hive.registerAdapter(PsychoROAAdapter());
    Hive.registerAdapter(PsychoDoseAdapter());
    Hive.registerAdapter(PsychoDurationDataAdapter());
    Hive.registerAdapter(PsychoDoseDataAdapter());
    Hive.registerAdapter(EffectAdapter());
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(EffectTypeAdapter());
    Hive.registerAdapter(EffectCategoryAdapter());
    Hive.registerAdapter(SubEffectCategoryAdapter());
  }

  static HiveObject? getValueByKey(Box box, String key) {
    try {
      return box.values.firstWhere((element) => element.entryKey == key) as HiveObject?;
    } catch (e) {
      return null;
    }
  }

  HiveObject? getValueByName(Box box, String name) {
    HiveObject? result;
    try {
      result = box.values.firstWhere((element) => element.name.toLowerCase() == name.toLowerCase()) as HiveObject?;
    } catch (e) {
      // print('HiveUtils::getValueByName: Failed to get item by name, trying prettyName instead');
      try {
        result = box.values.firstWhere((element) => element.prettyName.toLowerCase() == name.toLowerCase()) as HiveObject?;
      } catch (e) {
        // print("Warning! HiveUtils::getValueByName: No value with the name '" + name + "'");
        return null;
      }
    }
    return result;
  }

  SubstanceExtra? getValueExtra(Box box, String? name) {
    try {
      return box.values.firstWhere((element) => (element as SubstanceExtra).name == name) as SubstanceExtra?;
    } catch (e) {
      print("Warning! HiveUtils::getValueExtra: $e");
      return null;
    }
  }

  Future<void> deleteDatabase() async {
    await Hive.deleteBoxFromDisk("stashes");
    await Hive.deleteBoxFromDisk("entries");
    await Hive.deleteBoxFromDisk("notes");
    await Hive.deleteBoxFromDisk("substanceExtras");
    print("HiveUtils::deleteDatabase: Database deleted from disk");
  }

  Future<void> closeCache() async {
    if (Hive.isBoxOpen('substances')) await Log().substances.close();
    if (Hive.isBoxOpen('categories')) await Log().categories.close();
  }
}
