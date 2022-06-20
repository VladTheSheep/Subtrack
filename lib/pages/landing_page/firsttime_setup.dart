import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/application/create_log_notifier.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/consts/sizes.dart';
import 'package:subtrack/data/imported_database.dart';
import 'package:subtrack/database/hive_utils.dart';
import 'package:subtrack/managers/file_manager.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/pages/landing_page/prompt_header.dart';
import 'package:subtrack/providers.dart';
import 'package:subtrack/utils/snackbar_helper.dart';
import 'package:subtrack/utils/themes.dart';
import 'package:subtrack/widgets/buttons/button_row.dart';
import 'package:subtrack/widgets/slide_replace_widget.dart';

final _beginLoadWidgetProvider = StateProvider<Widget>((ref) {
  final CreateLogNotifierState state = ref.watch(createLogNotifierProvider);
  const double size = 75;
  final Widget loading = SpinKitDoubleBounce(
    size: size,
    color: Themes().getTheme().colorScheme.secondary,
  );

  return state.maybeWhen(
    initial: () => Container(),
    loadingCache: () => loading,
    loadingLog: () => loading,
    error: (_) => const SpinKitPulse(
      duration: Duration(milliseconds: 500),
      color: empathogenColorMat,
    ),
    loaded: () => const FaIcon(
      FontAwesomeIcons.lightCheckCircle,
      color: cannabisColorMat,
      size: size,
    ),
    orElse: () => Container(),
  );
});

final _beginLoadProvider = FutureProvider<bool>((ref) {
  final CreateLogNotifierState state = ref.watch(createLogNotifierProvider);

  return state.maybeWhen(
    initial: () => false,
    loadingCache: () => true,
    loadingLog: () => true,
    error: (_) => true,
    loaded: () => true,
    orElse: () => false,
  );
});

class FirstTimeSetup extends StatelessWidget {
  const FirstTimeSetup({
    Key? key,
    this.setupComplete = false,
  }) : super(key: key);

  final bool setupComplete;

  @override
  Widget build(BuildContext context) {
    const Widget child1 = _FirstTimeSetupView(key: ValueKey("child_1"));
    const Widget child2 = _DatabaseLoadView(key: ValueKey("child_2"));
    final Widget firstTimeSlideWidget = SlideReplaceWidget(
      child1: child1,
      child2: child2,
      stateProvider: _beginLoadProvider,
    );

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      child: Container(
        width: Nav().screenWidth - (Nav().screenWidth / 5),
        height: Nav().screenHeight - (Nav().screenHeight / 1.5),
        decoration: BoxDecoration(
          color: bgColorMat,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: WelcomeHeader(
                setupComplete: setupComplete,
                stateProvider: _beginLoadProvider,
              ),
            ),
            Expanded(
              child: setupComplete ? child2 : firstTimeSlideWidget,
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
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: ref.watch(_beginLoadWidgetProvider),
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
                    initial: () => "Idle...",
                    loaded: () => "Loaded!",
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
                          final watch = ref.watch(loadTextProvider);
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) {
                              final watch = ref.watch(loadTextProvider);
                              if (watch == "Loaded!") {
                                Navigator.popAndPushNamed(context, "/diary");
                              }
                            },
                          );

                          return Text(
                            watch,
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
              CreateLogNotifierState state = ref.watch(createLogNotifierProvider);
              return ButtonRow(
                leftText: "Import",
                rightText: "Next",
                leftColor: depressantColorMat,
                rightColor: cannabisColorMat,
                callback: (val) {
                  _buttonTapped(val).then((value) {
                    if (value != null) {
                      state = const CreateLogNotifierState.loadingCache();
                    }
                    if (value != null && state == const CreateLogNotifierState.loadingCache()) {
                      _beginLoading(ref, value: value);
                    }
                  });
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
      final result = await FileManager().pickPath();
      return result == false ? null : "";
    } else {
      final result = await FileManager().pickJson();
      if (result != null) {
        final result = await FileManager().pickPath();
        return result == false ? null : "";
      }
      return null;
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
              children: const [
                Text(
                  "Supported apps",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
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
