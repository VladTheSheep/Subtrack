import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:subtrack/managers/file_manager.dart';

part 'permissions_notifier.freezed.dart';

@freezed
class PermissionsNotifierState with _$PermissionsNotifierState {
  const factory PermissionsNotifierState.initial() = _Initial;
  const factory PermissionsNotifierState.error(String errorText) = _ErrorText;
  const factory PermissionsNotifierState.granted() = _Granted;
  const factory PermissionsNotifierState.notGranted() = _NotGranted;
}

class PermissionsNotifier extends StateNotifier<PermissionsNotifierState> {
  PermissionsNotifier() : super(const PermissionsNotifierState.initial());

  Future<void> hasPermissions() async {
    final bool res = await FileManager().hasStoragePermission;
    if (res) {
      state = const PermissionsNotifierState.granted();
    } else {
      state = const PermissionsNotifierState.notGranted();
    }
  }

  Future<void> grantPermissions() async {
    final bool res = await FileManager().hasStoragePermission;
    if (res) {
      state = const PermissionsNotifierState.granted();
    } else {
      await FileManager().requestStoragePermission;
      final bool res = await FileManager().hasStoragePermission;
      if (res) {
        state = const PermissionsNotifierState.granted();
      } else {
        state = const PermissionsNotifierState.notGranted();
      }
    }
  }
}
