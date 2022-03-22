import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imperium/navigation/nav.dart';
import 'package:imperium/pages/landing_page.dart';
import 'package:imperium/providers/theme.dart';
import 'package:imperium/utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Themes().initTheme();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final ThemeData theme = ref.watch(themeProvider);
        return MaterialApp(
          title: 'Imperium',
          theme: theme,
          navigatorKey: Nav().navKey,
          home: Navigator(
            // ignore: prefer_const_literals_to_create_immutables
            pages: [
              const MaterialPage(
                key: ValueKey('LandingPage'),
                child: LandingPage(),
              ),
            ],
            onPopPage: (Route<dynamic> route, dynamic result) => route.didPop(result),
          ),
        );
      },
    );
  }
}
