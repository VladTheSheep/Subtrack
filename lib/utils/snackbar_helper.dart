import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imperium/consts/colors.dart';
import 'package:imperium/consts/sizes.dart';
import 'package:imperium/navigation/nav.dart';
import 'package:imperium/utils/themes.dart';

void showSnackBar(
  String text, {
  String? secondaryText,
  bool secondTextStyle = false,
  TextStyle? secondStyle,
  int duration = 1500,
  bool prevState = false,
  SnackBarAction? action,
  Widget icon = const FaIcon(FontAwesomeIcons.question),
  Color? barColor,
}) {
  Widget? secondText;
  if (secondaryText != null) {
    TextStyle? style;
    if (secondStyle != null) {
      style = secondStyle;
    } else if (secondTextStyle) {
      style = TextStyle(color: Themes().getTheme().colorScheme.secondary, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
    }

    secondText = Text(secondaryText, style: style);
  }

  barColor ??= bgColorMat;
  // barColor ??= Themes().getTheme().colorScheme.secondary;

  ScaffoldMessenger.of(Nav().navKey.currentContext!).showSnackBar(
    SnackBar(
      elevation: ELEVATION,
      duration: Duration(milliseconds: duration),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.only(bottom: 10, right: 25, left: 25),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      backgroundColor: barColor.withOpacity(.7),
      behavior: SnackBarBehavior.floating,
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 25, maxHeight: 25),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const Padding(padding: EdgeInsets.all(5.0)),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(text, overflow: TextOverflow.fade),
                  if (secondText != null) const Padding(padding: EdgeInsets.all(2.0)) else Container(),
                  secondText ?? Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
