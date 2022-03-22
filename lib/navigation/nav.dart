import 'package:flutter/widgets.dart';

class Nav {
  static final Nav _nav = Nav._internal();

  factory Nav() => _nav;
  Nav._internal();

  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  double get screenWidth => MediaQuery.of(navKey.currentContext!).size.width;
  double get screenHeight => MediaQuery.of(navKey.currentContext!).size.height;
}
