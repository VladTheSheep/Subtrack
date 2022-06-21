import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/pages/diary_page.dart';
import 'package:subtrack/pages/stashes_page.dart';
import 'package:subtrack/pages/stats_page.dart';
import 'package:subtrack/pages/substances_page.dart';
import 'package:subtrack/utils/settings.dart';
import 'package:subtrack/widgets/nav_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> pages = [
      const DiaryPage(),
      if (Settings().data.wokeMode) const StashesPage(),
      const SubstancesPage(),
      const StatsPage(),
    ];

    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Nav().homeNavKey.currentState,
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
    );
  }
}
