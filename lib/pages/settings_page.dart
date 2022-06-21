import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/navigation/nav.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Nav().pushNamed("/home") as bool,
      child: Scaffold(
        backgroundColor: bgColorMat,
        appBar: AppBar(
          title: const Text("Settings"),
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Nav().pushNamed("/home"),
                icon: const FaIcon(FontAwesomeIcons.lightChevronLeft),
              );
            },
          ),
        ),
        body: Container(),
      ),
    );
  }
}
