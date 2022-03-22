import 'package:flutter/material.dart';
import 'package:imperium/consts/colors.dart';
import 'package:imperium/consts/sizes.dart';
import 'package:imperium/widgets/buttons/custom_button.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key? key,
    required this.leftText,
    required this.rightText,
    this.leftColor = Colors.white,
    this.rightColor = Colors.white,
    required this.callback,
  }) : super(key: key);

  final String leftText;
  final String rightText;
  final Color leftColor;
  final Color rightColor;
  final Function(bool val) callback;

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
          ),
        ),
        Container(
          height: BUTTON_HEIGHT - 20,
          width: 1,
          color: appBarColorMat,
        ),
        Expanded(
          child: CustomButton(
            text: rightText,
            color: rightColor,
            callback: callback,
            callbackValue: true,
          ),
        ),
      ],
    );
  }
}
