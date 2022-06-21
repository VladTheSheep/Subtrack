import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subtrack/application/log_notifier.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/consts/sizes.dart';
import 'package:subtrack/providers.dart';
import 'package:subtrack/widgets/slide_replace_widget.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    Key? key,
    this.setupComplete = false,
    this.headerText = "First Time Setup",
    this.noProgressBar = false,
    this.stateProvider,
  }) : super(key: key);

  final bool setupComplete;
  final String headerText;
  final bool noProgressBar;
  final FutureProvider<bool>? stateProvider;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 3;
    const double _progressBarStartPos = 5;
    final double _progressBarFinalPos = MediaQuery.of(context).size.width / 2.25;

    final Widget progressBar = Consumer(
      builder: (context, ref, child) {
        final loading = ref.watch(createLogNotifierProvider);

        final double left = loading.maybeWhen(
          initial: () => _progressBarStartPos,
          loadingCache: () => _progressBarFinalPos,
          loadingLog: () => _progressBarFinalPos,
          loaded: () => _progressBarFinalPos,
          error: (_) => _progressBarStartPos,
          orElse: () => _progressBarStartPos,
        );

        return AnimatedPositioned(
          left: left,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 2000),
          child: Container(
            height: 2.5,
            width: width,
            decoration: BoxDecoration(
              color: cannabisColorMat.withOpacity(0.75),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(borderRadius + 12)),
            ),
          ),
        );
      },
    );

    return Stack(
      children: [
        HeaderProgressBar(stateProvider: stateProvider),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: appBarColorMat.shade600,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(borderRadius),
            ),
          ),
          child: Container(),
        ),
        if (noProgressBar) Container() else progressBar,
      ],
    );
  }
}

class HeaderProgressBar extends StatelessWidget {
  const HeaderProgressBar({
    Key? key,
    this.headerText = "First Time Setup",
    this.stateProvider,
  }) : super(key: key);

  final String headerText;
  final FutureProvider<bool>? stateProvider;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: appBarColorMat.shade600,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: stateProvider != null
            ? SlideReplaceWidget(
                child1: Text(
                  headerText,
                  key: const ValueKey("child_1"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: headerTextSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child2: Consumer(
                  key: const ValueKey("child_2"),
                  builder: (context, ref, child) {
                    final LogNotifierState state = ref.watch(createLogNotifierProvider);

                    final String text = state.maybeWhen(
                      error: (errorText) => "Error $errorText",
                      orElse: () => "Loading...",
                    );

                    return Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: headerTextSize,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
                stateProvider: stateProvider!,
              )
            : Align(
                child: Text(
                  headerText,
                  key: const ValueKey("child_1"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: headerTextSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}
