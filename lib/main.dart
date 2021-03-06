import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subtrack/application/permissions_notifier.dart';
import 'package:subtrack/database/hive_utils.dart';
import 'package:subtrack/managers/file_manager.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/pages/home_page.dart';
import 'package:subtrack/pages/landing_page.dart';
import 'package:subtrack/pages/settings_page.dart';
import 'package:subtrack/providers.dart';
import 'package:subtrack/utils/settings.dart';
import 'package:subtrack/utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Themes().initTheme();
  HiveUtils().registerAdapters();

  FileManager().initAppDirectory().then(
        (_) => PermissionsNotifier().hasPermissions().then(
              (_) => Settings().readSettings().then(
                    (_) => Settings().initSettings().then(
                          (_) => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
                            (_) => runApp(
                              const ProviderScope(
                                child: MyApp(),
                              ),
                            ),
                          ),
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
          navigatorKey: Nav().navKey,
          title: 'Subtrack',
          theme: ref.watch(themeProvider),
          home: LandingPage(),
          routes: {
            "/settings": (context) => const SettingsPage(),
            "/home": (context) => HomePage(),
          },
        );
      },
    );
  }
}
