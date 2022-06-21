import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/pages/diary_page.dart';
import 'package:subtrack/pages/home_page/home_drawer.dart';
import 'package:subtrack/pages/stashes_page.dart';
import 'package:subtrack/pages/stats_page.dart';
import 'package:subtrack/pages/substances_page.dart';
import 'package:subtrack/utils/settings.dart';
import 'package:subtrack/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> homeNavKey = GlobalKey<ScaffoldState>(debugLabel: "home");
  final GlobalKey drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DiaryPage(),
      if (Settings().data.wokeMode) const StashesPage(),
      const SubstancesPage(),
      const StatsPage(),
    ];

    final PageController controller = PageController();
    return Scaffold(
      key: homeNavKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            final bool drawerOpen = drawerKey.currentContext?.findRenderObject() != null;
            if (drawerOpen) {
              Navigator.of(homeNavKey.currentContext!).pop();
            } else {
              homeNavKey.currentState?.openDrawer();
            }
          },
          icon: const FaIcon(FontAwesomeIcons.lightBars),
        ),
      ),
      body: DecoratedBox(
        decoration: linearBg,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavBar(controller: controller),
      drawer: HomeDrawer(drawerKey: drawerKey),
    );
  }
}
