import 'package:flutter/material.dart';

class Nav {
  static final Nav _nav = Nav._internal();

  factory Nav() => _nav;
  Nav._internal();

  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>(debugLabel: "root");

  double get screenWidth => MediaQuery.of(navKey.currentContext!).size.width;
  double get screenHeight => MediaQuery.of(navKey.currentContext!).size.height;

  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 750),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
