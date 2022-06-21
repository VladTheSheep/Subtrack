import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subtrack/utils/themes.dart';

Widget getImage(String path, {double size = 32.0}) => Image(image: AssetImage(path), width: size, height: size);

Widget getSVG(String? path, {Color? color, double size = 32.0}) => SvgPicture.asset(
      path ?? 'assets/icons/unknown.svg',
      color: color,
      height: size,
      width: size,
    );

Widget getLogo({Color? color, double size = 86.0}) => getSVG(
      'assets/icons/logo.svg',
      color: color ?? Themes().accentColor,
      size: size,
    );
