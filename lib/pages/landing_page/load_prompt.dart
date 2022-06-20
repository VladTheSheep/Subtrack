import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:subtrack/application/log_notifier.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/pages/animated_route.dart';
import 'package:subtrack/pages/diary.dart';
import 'package:subtrack/providers.dart';
import 'package:subtrack/utils/themes.dart';

class LoadPrompt extends ConsumerWidget {
  const LoadPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000)).then((value) {
        ref.watch(createLogNotifierProvider.notifier).loadLog().then(
          (state) {
            if (state == const LogNotifierState.loaded()) {
              Navigator.pushReplacement(context, createRoute(const DiaryPage()));
            }
          },
        );
      });
    });
    return Padding(
      padding: EdgeInsets.only(top: Nav().screenHeight / 6),
      child: SpinKitDancingSquare(
        size: 82,
        color: Themes().getTheme().colorScheme.secondary,
      ),
    );
  }
}
