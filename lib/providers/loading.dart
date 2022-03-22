import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FailStates {
  None,
  Category,
  Substance,
  Import,
  Entry,
  Stash,
  Note,
  Cache,
  Log,
}

String failStateToString(FailStates state) {
  switch (state) {
    case FailStates.None:
      return "Unknown error!";

    case FailStates.Category:
      return "Unable to retrieve category data from API";

    case FailStates.Substance:
      return "Unable to retrieve substance data from API";

    case FailStates.Import:
      return "Unable to import specified file";

    case FailStates.Entry:
      return "An error occurred while loading your entries";

    case FailStates.Stash:
      return "An error occurred while loading your stash";

    case FailStates.Note:
      return "An error occurred while loading your notes";

    case FailStates.Cache:
      return "API request failed";

    case FailStates.Log:
      return "An error occurred while loading your log";
  }
}

final loadingProvider = StateProvider<String>((ref) => "");
final subtitleLoadingProvider = StateProvider<String>((ref) => "");
final loadFailProvider = StateProvider<FailStates>((ref) => FailStates.None);
final loadMinorFailProvider = StateProvider<FailStates>((ref) => FailStates.None);
final loadSuccessProvider = StateProvider((ref) => false);
