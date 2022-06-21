import 'package:flutter/material.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/utils/settings.dart';

class Themes {
  static final Themes _themes = Themes._internal();

  factory Themes() => _themes;
  Themes._internal();

  static const String fontFamily = 'SourceSansPro';
  late ThemeData theme;

  void initTheme() {
    MaterialColor color;
    if (Settings().data.accentColor == "Green") {
      color = cannabisColorMat;
    } else if (Settings().data.accentColor == "Blue") {
      color = researchColorMat;
    } else if (Settings().data.accentColor == "Red") {
      color = empathogenColorMat;
    } else if (Settings().data.accentColor == "Yellow") {
      color = depressantColorMat;
    } else if (Settings().data.accentColor == "Orange") {
      color = habitColorMat;
    } else if (Settings().data.accentColor == "Purple") {
      color = psychColorMat;
    } else {
      color = cannabisColorMat;
    }

    theme = ThemeData(
      primaryColorLight: Colors.green,
      brightness: Brightness.dark,
      canvasColor: bgColorMat,
      unselectedWidgetColor: unselectedWidgetColorMat.shade900,
      secondaryHeaderColor: lightBgColorMat,
      dialogBackgroundColor: inactiveColorMat,
      cardColor: bottomAppBarColorMat,
      hintColor: color.withOpacity(0.3),
      scaffoldBackgroundColor: Colors.transparent,
      bottomAppBarColor: lightBottomAppBarColorMat,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: appBarColorMat,
        contentTextStyle: TextStyle(color: Colors.white),
        elevation: 5.0,
        behavior: SnackBarBehavior.floating,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarColorMat,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      dialogTheme: const DialogTheme(backgroundColor: appBarColorMat),
      fontFamily: fontFamily,
      shadowColor: lighterUnselectedColorMat,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: color).copyWith(
        secondary: color,
        brightness: Brightness.dark,
      ),
    );
  }

  Color get accentColor => Themes().getTheme().colorScheme.secondary;

  ThemeData get green => theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: cannabisColorMat).copyWith(secondary: cannabisColorMat),
      );

  ThemeData get blue => theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: researchColorMat).copyWith(secondary: researchColorMat),
      );

  ThemeData get red => theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: empathogenColorMat).copyWith(secondary: empathogenColorMat),
      );

  ThemeData get yellow => theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: depressantColorMat).copyWith(secondary: depressantColorMat),
      );

  ThemeData get orange => theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: habitColorMat).copyWith(secondary: habitColorMat),
      );

  ThemeData get purple => theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: psychColorMat).copyWith(secondary: psychColorMat),
      );

  ThemeData getTheme() {
    switch (Settings().data.accentColor.toLowerCase()) {
      case 'green':
        return green;

      case 'blue':
        return blue;

      case 'red':
        return red;

      case 'yellow':
        return yellow;

      case 'orange':
        return orange;

      case 'purple':
        return purple;

      default:
        print('ERROR!! Themes::getTheme: Invalid theme!');
        return theme;
    }
  }
}
