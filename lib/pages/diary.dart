import 'package:flutter/widgets.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/consts/sizes.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: empathogenColorMat,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        height: 100,
        width: 100,
      ),
    );
  }
}
