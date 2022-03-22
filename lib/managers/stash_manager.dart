import 'package:imperium/database/log.dart';
import 'package:imperium/database/models/stash.dart';

class StashManager {
  static final StashManager _stashManager = StashManager._internal();

  factory StashManager() => _stashManager;
  StashManager._internal();

  Future<String?> loadStashData(List<Stash> stashes) async {
    // int count = 0;
    for (final Stash stash in stashes) {
      await Future.delayed(Duration.zero);
      if (Log().substances.values.isEmpty) return "StashManager::loadStashData: No substances in cache";
      stash.substanceKey = Log()
          .substances
          .values
          .firstWhere(
            (element) => element.name!.toLowerCase() == stash.substanceName!.toLowerCase(),
          )
          .key as int?;

      if (stash.substanceKey == null) print("ERROR!! StashManager::loadStashData: No substance key!");
    }

    // print("StashManager::loadStashData: Fixed $count");
    return null;
  }
}
