import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:subtrack/utils/settings.dart';

part 'navbar_notifier.freezed.dart';

@freezed
class NavBarNotifierState with _$NavBarNotifierState {
  const factory NavBarNotifierState.diary() = _Diary;
  const factory NavBarNotifierState.stash() = _Stash;
  const factory NavBarNotifierState.database() = _Database;
  const factory NavBarNotifierState.stats() = _Stats;
}

class NavBarNotifier extends StateNotifier<NavBarNotifierState> {
  NavBarNotifier() : super(const NavBarNotifierState.diary());

  NavBarNotifierState intToState(int number) {
    if (Settings().data.wokeMode) {
      if (number == 0) {
        return state = const NavBarNotifierState.diary();
      }
      if (number == 1) {
        return state = const NavBarNotifierState.stash();
      }
      if (number == 2) {
        return state = const NavBarNotifierState.database();
      }
      if (number == 3) {
        return state = const NavBarNotifierState.stats();
      }
      throw Exception("No such page");
    } else {
      if (number == 0) {
        return state = const NavBarNotifierState.diary();
      }
      if (number == 1) {
        return state = const NavBarNotifierState.database();
      }
      if (number == 2) {
        return state = const NavBarNotifierState.stats();
      }
      throw Exception("No such page");
    }
  }
}
