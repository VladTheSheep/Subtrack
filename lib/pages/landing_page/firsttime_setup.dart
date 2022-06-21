import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/application/log_notifier.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/consts/sizes.dart';
import 'package:subtrack/data/imported_database.dart';
import 'package:subtrack/managers/file_manager.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/pages/home_page.dart';
import 'package:subtrack/pages/landing_page/prompt_header.dart';
import 'package:subtrack/providers.dart';
import 'package:subtrack/utils/snackbar_helper.dart';
import 'package:subtrack/utils/themes.dart';
import 'package:subtrack/widgets/buttons/button_row.dart';
import 'package:subtrack/widgets/slide_replace_widget.dart';

class FirstTimeSetup extends StatelessWidget {
  FirstTimeSetup({
    Key? key,
    this.setupComplete = false,
  }) : super(key: key);

  final bool setupComplete;

  final _beginLoadProvider = FutureProvider<bool>((ref) {
    final LogNotifierState state = ref.watch(createLogNotifierProvider);

    return state.maybeWhen(
      initial: () => false,
      loadingCache: () => true,
      loadingLog: () => true,
      error: (_) => true,
      loaded: () => true,
      orElse: () => false,
    );
  });

  @override
  Widget build(BuildContext context) {
    const Widget child1 = _FirstTimeSetupView(key: ValueKey("child_1"));
    final Widget child2 = _DatabaseLoadView(key: const ValueKey("child_2"));
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
  _DatabaseLoadView({
    Key? key,
  }) : super(key: key);

  final _beginLoadWidgetProvider = StateProvider<Widget>((ref) {
    final LogNotifierState state = ref.watch(createLogNotifierProvider);
    const double size = 75;
    final Widget loading = SpinKitDoubleBounce(
      size: size,
      color: Themes().accentColor,
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

  final loadTextProvider = StateProvider((ref) {
    final LogNotifierState state = ref.watch(createLogNotifierProvider);
    return state.maybeWhen(
      initial: () => "Idle...",
      loaded: () => "Loaded!",
      loadingCache: () => "Fetching API data...",
      loadingLog: () => "Loading log...",
      error: (errorText) => errorText,
      orElse: () => "Something went wrong!",
    );
  });

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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) {
                              final watch = ref.watch(loadTextProvider);
                              if (watch == "Loaded!") {
                                Navigator.pushReplacement(context, Nav().createRoute(HomePage()));
                              }
                            },
                          );

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
              return ButtonRow(
                leftText: "Import",
                rightText: "Next",
                leftColor: depressantColorMat,
                rightColor: cannabisColorMat,
                callback: (val) => _buttonTapped(val, ref),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _buttonTapped(bool val, WidgetRef ref) async {
    try {
      String? response;
      String? imported;
      ImportedDatabase? import;
      if (val) {
        response = await FileManager().pickPath() == false ? null : "";
      } else {
        imported = await FileManager().pickJson();
        if (imported != null) {
          import = ImportedDatabase.fromRawJson(imported);
          response = await FileManager().pickPath() == false ? null : "";
        }
      }

      if (response != null) {
        ref.watch(createLogNotifierProvider.notifier).createLog(import: import);
      }
    } catch (e) {
      showSnackBar(
        "Unsupported / corrupted file",
        icon: const FaIcon(FontAwesomeIcons.lightFileExclamation),
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
