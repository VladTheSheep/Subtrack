import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imperium/application/create_log_notifier.dart';
import 'package:imperium/consts/colors.dart';
import 'package:imperium/consts/sizes.dart';
import 'package:imperium/data/imported_database.dart';
import 'package:imperium/database/hive_utils.dart';
import 'package:imperium/managers/file_manager.dart';
import 'package:imperium/navigation/nav.dart';
import 'package:imperium/providers.dart';
import 'package:imperium/utils/image_helper.dart';
import 'package:imperium/utils/snackbar_helper.dart';
import 'package:imperium/utils/themes.dart';
import 'package:imperium/widgets/buttons/button_row.dart';
import 'package:imperium/widgets/slide_replace_widget.dart';

final _animateProvider = StateProvider<int>((ref) => 1);
final _beginLoadProvider = FutureProvider<bool>((ref) {
  final CreateLogNotifierState state = ref.watch(createLogNotifierProvider);
  return state.maybeWhen(
    initial: () => false,
    loadingCache: () => true,
    loadingLog: () => true,
    loaded: () => true,
    orElse: () => Future.delayed(const Duration(milliseconds: 3000), () => false),
  );
});

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _Logo(),
        Consumer(
          builder: (context, ref, child) {
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) => Future.delayed(const Duration(milliseconds: 500)).then((value) => ref.watch(_animateProvider.notifier).state = 2),
            );
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              top: Nav().screenHeight / ref.watch(_animateProvider),
              left: 35,
              right: 35,
              child: const _FirstTimeSetup(),
            );
          },
        ),
      ],
    );
  }
}

class _FirstTimeSetup extends StatelessWidget {
  const _FirstTimeSetup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: ELEVATION,
      child: Container(
        width: Nav().screenWidth - (Nav().screenWidth / 5),
        height: Nav().screenHeight - (Nav().screenHeight / 1.5),
        decoration: BoxDecoration(
          color: bgColorMat,
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: _WelcomeHeader(),
            ),
            Expanded(
              child: SlideReplaceWidget(
                child1: const _FirstTimeSetupView(key: ValueKey("child_1")),
                child2: const _DatabaseLoadView(key: ValueKey("child_2")),
                stateProvider: _beginLoadProvider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DatabaseLoadView extends StatelessWidget {
  const _DatabaseLoadView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 100,
          child: Consumer(
            builder: (context, ref, child) {
              const double size = 75;

              final CreateLogNotifierState state = ref.watch(createLogNotifierProvider);

              final String? errorText = state.maybeWhen(
                error: (errorText) => errorText,
                orElse: () => null,
              );

              final bool loaded = state.maybeWhen(
                loaded: () => true,
                orElse: () => false,
              );

              late Widget child;

              if (errorText != null) {
                child = const SpinKitPulse(
                  duration: Duration(milliseconds: 500),
                  color: empathogenColorMat,
                );
              } else if (loaded) {
                child = const FaIcon(
                  FontAwesomeIcons.lightCheckCircle,
                  color: cannabisColorMat,
                  size: size,
                );
              } else {
                child = SpinKitDoubleBounce(
                  size: size,
                  color: Themes().getTheme().colorScheme.secondary,
                );
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: child,
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 130,
          child: Align(
            child: Consumer(
              builder: (context, ref, child) {
                final loadTextProvider = StateProvider((ref) {
                  final CreateLogNotifierState state = ref.watch(createLogNotifierProvider);
                  return state.maybeWhen(
                    loaded: () => "Done!",
                    loadingCache: () => "Fetching API data...",
                    loadingLog: () => "Loading log...",
                    error: (errorText) => errorText,
                    orElse: () => "Something went wrong!",
                  );
                });

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          return Text(
                            ref.watch(loadTextProvider),
                            style: const TextStyle(fontSize: 16.0),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _FirstTimeSetupView extends StatelessWidget {
  const _FirstTimeSetupView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _WelcomeContent(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Consumer(
            builder: (context, ref, child) {
              final CreateLogNotifierState state = ref.watch(createLogNotifierProvider);
              final bool loading = state.maybeWhen(
                loadingCache: () => true,
                loadingLog: () => true,
                loaded: () => true,
                orElse: () => false,
              );
              return ButtonRow(
                leftText: "Import",
                rightText: "Next",
                leftColor: depressantColorMat,
                rightColor: cannabisColorMat,
                callback: (val) {
                  if (!loading) {
                    _buttonTapped(val).then((value) => _beginLoading(ref, value: value));
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Future<String?> _buttonTapped(bool val) async {
    if (val) {
      return "";
    } else {
      return FileManager().pickJson();
    }
  }

  void _beginLoading(WidgetRef ref, {String? value}) {
    try {
      ImportedDatabase? import;
      if (value != null && value.isNotEmpty) {
        import = ImportedDatabase.fromRawJson(value);
      }
      HiveUtils().initHive().then((value) {
        ref.watch(createLogNotifierProvider.notifier).createLog(import: import);
      });
    } on InvalidJsonException {
      late String text;
      if (value != null) {
        text = "Unable to import the specified file";
      } else {
        text = "Something went wrong!";
      }
      showSnackBar(
        text,
        icon: const FaIcon(
          FontAwesomeIcons.lightFileExclamation,
        ),
        barColor: empathogenColorMat,
        duration: 3000,
      );
    }
  }
}

class _WelcomeContent extends StatelessWidget {
  const _WelcomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: const TextSpan(
                text: "To create a new log, hit ",
                children: [
                  TextSpan(
                    text: "Next",
                    style: TextStyle(
                      color: cannabisColorMat,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: const TextSpan(
                text: "Already using a drug logging app? Use ",
                children: [
                  TextSpan(
                    text: "Import",
                    style: TextStyle(
                      color: depressantColorMat,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: " to import your existing log"),
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(4.0)),
          const Divider(),
          const Padding(padding: EdgeInsets.all(2.0)),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "Supported apps",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Json only",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: depressantColorMat,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(4.0)),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Imperium",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 3;
    const double _progressBarStartPos = 5;
    final double _progressBarFinalPos = MediaQuery.of(context).size.width / 2.25;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: appBarColorMat.shade600,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(BORDER_RADIUS),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SlideReplaceWidget(
              child1: const Text(
                "First Time Setup",
                key: ValueKey("child_1"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: HEADER_TEXT_SIZE,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child2: Consumer(
                key: const ValueKey("child_2"),
                builder: (context, ref, child) {
                  final CreateLogNotifierState state = ref.watch(createLogNotifierProvider);

                  final String text = state.maybeWhen(
                    error: (errorText) => "Error",
                    orElse: () => "Loading...",
                  );

                  return Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: HEADER_TEXT_SIZE,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
              stateProvider: _beginLoadProvider,
            ),
          ),
        ),
        // ),
        Consumer(
          builder: (context, ref, child) {
            final AsyncValue<bool> loading = ref.watch(_beginLoadProvider);

            final double left = loading.maybeWhen(
              data: (val) => val ? _progressBarFinalPos : _progressBarStartPos,
              loading: () => _progressBarFinalPos,
              error: (_, __) => _progressBarStartPos,
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(BORDER_RADIUS + 12)),
                ),
              ),
            );
          },
        ),
      ],
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
