import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/consts/strings.dart';
import 'package:subtrack/database/hive_utils.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/utils/image_helper.dart';
import 'package:subtrack/utils/settings.dart';
import 'package:subtrack/utils/themes.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.drawerKey,
  }) : super(key: key);

  final GlobalKey drawerKey;

  @override
  Widget build(BuildContext context) {
    const double versionFontSize = 12.0;
    return Drawer(
      key: drawerKey,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: linearBg,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
                      child: Stack(
                        children: [
                          Align(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: getLogo(size: 96),
                                ),
                                const Text(
                                  appName,
                                  style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('Version ', style: TextStyle(fontSize: versionFontSize)),
                                    Text(
                                      Settings().packageInfo.version,
                                      style: TextStyle(
                                        fontSize: versionFontSize,
                                        color: Themes().accentColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    const Text('Build ', style: TextStyle(fontSize: versionFontSize)),
                                    Text(
                                      Settings().packageInfo.buildNumber,
                                      style: TextStyle(
                                        fontSize: versionFontSize,
                                        color: Themes().accentColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0.75,
                  color: Themes().accentColor,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                DrawerEntryPage(
                  text: 'Settings',
                  func: () async {
                    Navigator.pop(context);
                    await Navigator.of(context).pushNamed("/settings");
                    // Navigator.of(Nav().navKey.currentContext!).popUntil(ModalRoute.withName("/settings"));
                  },
                  leading: const FaIcon(FontAwesomeIcons.lightCog),
                ),
                Divider(
                  height: 0.5,
                  color: Themes().getTheme().unselectedWidgetColor,
                ),
                DrawerEntryPage(
                  text: 'Lock database',
                  func: () async {
                    await HiveUtils().closeBoxes();
                    await SystemNavigator.pop();
                  },
                  leading: const FaIcon(
                    FontAwesomeIcons.lightSignOut,
                    color: empathogenColorMat,
                  ),
                  textColor: empathogenColorMat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerEntryPage extends StatelessWidget {
  const DrawerEntryPage({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    required this.leading,
    this.func,
    this.page,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final Widget leading;
  final Function? func;
  final Widget? page;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text, style: TextStyle(color: textColor)),
      leading: leading,
      onTap: () {
        if (func == null && page != null) {
          Navigator.of(Nav().navKey.currentContext!).push(
            MaterialPageRoute(builder: (context) => page!),
          );
        } else if (func != null) {
          func!();
        }
      },
    );
  }
}
