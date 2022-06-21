import 'package:flutter/material.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/consts/sizes.dart';
import 'package:subtrack/widgets/buttons/custom_button.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key? key,
    required this.leftText,
    required this.rightText,
    this.leftColor = Colors.white,
    this.rightColor = Colors.white,
    required this.callback,
    this.radius,
  }) : super(key: key);

  final String leftText;
  final String rightText;
  final Color leftColor;
  final Color rightColor;
  final Function(bool val) callback;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: CustomButton(
            text: leftText,
            color: leftColor,
            callback: callback,
            callbackValue: false,
            radius: radius ??
                const BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                ),
          ),
        ),
        Container(
          height: buttonHeight - 20,
          width: 1,
          color: appBarColorMat,
        ),
        Expanded(
          child: CustomButton(
            text: rightText,
            color: rightColor,
            callback: callback,
            callbackValue: true,
            radius: radius ??
                const BorderRadius.only(
                  bottomRight: Radius.circular(borderRadius),
                ),
          ),
        ),
      ],
    );
  }
}
