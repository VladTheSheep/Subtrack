import 'package:flutter/material.dart';
import 'package:subtrack/consts/sizes.dart';
import 'package:subtrack/consts/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.fontSize = buttonTextSize,
    this.height = buttonHeight,
    this.fontWeight = buttonTextWeight,
    this.radius,
    required this.callback,
    required this.callbackValue,
  }) : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final double height;
  final FontWeight fontWeight;
  final BorderRadius? radius;

  final Function(bool val) callback;
  final bool callbackValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: color.withOpacity(0.5),
        highlightColor: color.withOpacity(0.2),
        borderRadius: radius ?? BorderRadius.circular(borderRadius),
        onTap: () => callback(callbackValue),
        child: SizedBox(
          height: height,
          child: Align(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
