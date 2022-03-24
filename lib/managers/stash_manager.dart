import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/stash.dart';

class StashManager {
  static final StashManager _stashManager = StashManager._internal();

  factory StashManager() => _stashManager;
  StashManager._internal();

  void loadStashData(List<Stash> stashes) {
    // int count = 0;
    for (final Stash stash in stashes) {
      // if (Log().substances.values.isEmpty) return "StashManager::loadStashData: No substances in cache";
      stash.substanceKey = Log()
          .substances
          .values
          .firstWhere(
            (element) => element.name!.toLowerCase() == stash.substanceName!.toLowerCase(),
          )
          .key as int?;

      // if (stash.substanceKey == null) print("ERROR!! StashManager::loadStashData: No substance key!");
    }
  }
}
