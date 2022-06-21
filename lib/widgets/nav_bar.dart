import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/utils/settings.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

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
      child: BottomNavigationBar(
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
      ),
    );
  }
}
