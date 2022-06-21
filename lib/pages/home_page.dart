import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Nav().navKey.currentState,
          icon: const FaIcon(
            FontAwesomeIcons.lightBars,
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: linearBg,
        child: const Center(
          child: Text("pretend this is the diary page"),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
