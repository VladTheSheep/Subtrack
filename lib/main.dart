import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imperium/consts/colors.dart';
import 'package:imperium/database/hive_utils.dart';
import 'package:imperium/managers/file_manager.dart';
import 'package:imperium/navigation/nav.dart';
import 'package:imperium/pages/landing_page.dart';
import 'package:imperium/pages/root_page.dart';
import 'package:imperium/providers.dart';
import 'package:imperium/utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Themes().initTheme();
  HiveUtils().registerAdapters();

  FileManager().initPaths().then(
        (_) => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
          (_) => runApp(
            const ProviderScope(
              child: MyApp(),
            ),
          ),
        ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return MaterialApp(
          title: 'Imperium',
          theme: ref.watch(themeProvider),
          navigatorKey: Nav().navKey,
          home: DecoratedBox(
            decoration: LINEAR_BG,
            child: Navigator(
              // ignore: prefer_const_literals_to_create_immutables
              pages: [
                const MaterialPage(
                  key: ValueKey("RootPage"),
                  child: RootPage(),
                ),
                const MaterialPage(
                  key: ValueKey("LandingPage"),
                  child: LandingPage(),
                ),
              ],
              onPopPage: (Route<dynamic> route, dynamic result) => route.didPop(result),
            ),
          ),
        );
      },
    );
  }
}
