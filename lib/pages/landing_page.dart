import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subtrack/application/permissions_notifier.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/managers/file_manager.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/pages/landing_page/firsttime_setup.dart';
import 'package:subtrack/pages/landing_page/storage_prompt.dart';
import 'package:subtrack/providers.dart';
import 'package:subtrack/utils/image_helper.dart';
import 'package:subtrack/utils/settings.dart';

final _animateProvider = StateProvider<int>((ref) => 1);

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final _storagePermissionProvider = StateProvider<Widget>((ref) {
    PermissionsNotifierState state = ref.watch(storagePermissionsNotifierProvider);
    if (FileManager().storageGranted) {
      state = const PermissionsNotifierState.granted();
    }
    return state.maybeWhen(
      granted: () => FirstTimeSetup(setupComplete: Settings().data.hasCompletedSetup),
      notGranted: () => const StoragePrompt(),
      orElse: () => const Text("wut"),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: linearBg,
        child: Stack(
          children: [
            const _Logo(),
            Consumer(
              builder: (context, ref, child) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Future.delayed(const Duration(milliseconds: 500)).then((value) => ref.watch(_animateProvider.notifier).state = 2),
                );

                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutExpo,
                  top: Nav().screenHeight / ref.watch(_animateProvider),
                  left: 35,
                  right: 35,
                  child: ref.watch(_storagePermissionProvider),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150,
      left: 0,
      right: 0,
      child: Consumer(
        builder: (context, ref, child) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 2000),
            opacity: (ref.watch(_animateProvider) - 1).toDouble(),
            curve: Curves.easeOutExpo,
            child: getLogo(size: 175),
          );
        },
      ),
    );
  }
}
