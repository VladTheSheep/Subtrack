import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imperium/consts/colors.dart';
import 'package:imperium/consts/sizes.dart';
import 'package:imperium/consts/strings.dart';
import 'package:imperium/consts/text_styles.dart';
import 'package:imperium/managers/file_manager.dart';
import 'package:imperium/navigation/nav.dart';
import 'package:imperium/utils/image_helper.dart';
import 'package:imperium/utils/themes.dart';
import 'package:imperium/widgets/buttons/button_row.dart';
import 'package:imperium/widgets/show_up.dart';

final animateProvider = StateProvider<int>((ref) => 1);
final beginLoadProvider = StateProvider<double>((ref) => _progressBarStartPos);

double _progressBarStartPos = 5;
double _progressBarFinalPos = 0;

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: Nav().screenWidth,
        height: Nav().screenHeight,
        decoration: LINEAR_BG,
        child: Stack(
          children: [
            const _Logo(),
            Consumer(
              builder: (context, ref, child) {
                WidgetsBinding.instance!.addPostFrameCallback(
                  (_) async => Future.delayed(const Duration(milliseconds: 500)).then((value) => ref.watch(animateProvider.notifier).state = 2),
                );
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutExpo,
                  top: Nav().screenHeight / ref.watch(animateProvider),
                  left: Nav().screenWidth / 10,
                  child: Material(
                    color: Colors.transparent,
                    elevation: ELEVATION,
                    child: Container(
                      width: Nav().screenWidth - (Nav().screenWidth / 5),
                      height: Nav().screenHeight - (Nav().screenHeight / 1.5),
                      decoration: BoxDecoration(
                        color: Themes().getTheme().scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(BORDER_RADIUS),
                      ),
                      child: ClipRect(
                        child: Column(
                          children: [
                            const _WelcomeHeader(),
                            Expanded(
                              child: Stack(
                                children: [
                                  _FirstTimeSetupView(callback: _buttonTapped),
                                  const Positioned.fill(
                                    child: _DatabaseLoadView(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _buttonTapped(bool val) async {
    if (val) {
      return "";
    } else {
      return FileManager().pickJson();
    }
  }
}

class _DatabaseLoadView extends StatelessWidget {
  const _DatabaseLoadView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowUp(
      stateProvider: beginLoadProvider,
      offset: const Offset(1.0, 0.0),
      child: Stack(
        children: [
          Positioned(
            top: 35,
            left: 0,
            right: 0,
            child: SpinKitDoubleBounce(
              color: Themes().getTheme().colorScheme.secondary,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 50,
            child: Align(
              child: Consumer(
                builder: (context, ref, child) {
                  String text = "Creating directories...";
                  final bool pathInit = ref.watch(pathInitProvider);
                  if (pathInit) {
                    text = "Paths created";
                  }

                  return Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FirstTimeSetupView extends StatelessWidget {
  const _FirstTimeSetupView({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final Future<String?> Function(bool val) callback;

  @override
  Widget build(BuildContext context) {
    return ShowUp(
      stateProvider: beginLoadProvider,
      offset: const Offset(-1.0, 0.0),
      startInstantly: true,
      duration: 500,
      child: Stack(
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
                  callback: (val) {
                    callback(val).then((value) {
                      if (value != null) {
                        ref.watch(beginLoadProvider.notifier).state = _progressBarFinalPos;
                        if (value.isNotEmpty) {
                        } else {
                          FileManager().initPaths(ref);
                        }
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
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
    _progressBarFinalPos = MediaQuery.of(context).size.width / 2.25;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: appBarColorMat.shade600,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(BORDER_RADIUS),
              topRight: Radius.circular(BORDER_RADIUS),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRect(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: ShowUp(
                        stateProvider: beginLoadProvider,
                        offset: const Offset(-1.0, 0.0),
                        startInstantly: true,
                        duration: 500,
                        child: const Text(
                          "First Time Setup",
                          style: TextStyle(
                            fontSize: HEADER_TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: ShowUp(
                        stateProvider: beginLoadProvider,
                        offset: const Offset(1.5, 0.0),
                        child: const Text(
                          "Loading...",
                          style: TextStyle(
                            fontSize: HEADER_TEXT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            return AnimatedPositioned(
              left: ref.watch(beginLoadProvider),
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
      top: 190,
      left: 0,
      right: 0,
      child: Consumer(
        builder: (context, ref, child) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 2000),
            opacity: (ref.watch(animateProvider) - 1).toDouble(),
            curve: Curves.easeOutExpo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getLogo(size: 125),
                const Padding(
                  padding: EdgeInsets.only(right: 28.0),
                  child: Text(
                    APP_NAME,
                    style: LOGO_TEXT_STYLE,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
