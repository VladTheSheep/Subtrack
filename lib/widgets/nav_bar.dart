import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/providers.dart';
import 'package:subtrack/utils/settings.dart';
import 'package:subtrack/utils/themes.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10.0,
            spreadRadius: 5.0,
          )
        ],
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final int state = ref.watch(navBarStateNotifierProvider);
          return BottomNavigationBar(
            showUnselectedLabels: true,
            fixedColor: Themes().accentColor,
            unselectedItemColor: Themes().getTheme().unselectedWidgetColor,
            unselectedLabelStyle: TextStyle(color: Themes().getTheme().unselectedWidgetColor),
            currentIndex: state,
            onTap: (int index) {
              if (state != index) {
                ref.watch(navBarNotifierProvider.notifier).intToState(index);
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              }
            },
            items: [
              const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.lightCalendar),
                label: 'Diary',
              ),
              if (Settings().data.wokeMode)
                const BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.lightBox),
                  label: 'Stash',
                ),
              const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.lightCapsules),
                label: 'Database',
              ),
              const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.lightChartBar),
                label: 'Stats',
              ),
            ],
          );
        },
      ),
    );
  }
}
