import 'package:hive_flutter/adapters.dart';
import 'package:imperium/database/models/category.dart';
import 'package:imperium/database/models/entry.dart';
import 'package:imperium/database/models/note.dart';
import 'package:imperium/database/models/stash.dart';
import 'package:imperium/database/models/substance.dart';
import 'package:imperium/database/models/substance_extra.dart';
import 'package:imperium/managers/file_manager.dart';

class HiveUtils {
  static final HiveUtils _hiveUtils = HiveUtils._internal();

  factory HiveUtils() => _hiveUtils;
  HiveUtils._internal();

  Future<bool> initHive() async {
    await Hive.initFlutter(FileManager().getDatabasePath);
    return openBoxes();
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
        print("HiveUtils::openBox: '$box' not open, opening${password != null ? " with password" : ""}...");
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
}
