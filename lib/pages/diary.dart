import 'package:flutter/material.dart';
import 'package:subtrack/consts/colors.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: linearBg,
        child: const Center(
          child: Text("pretend this is the diary page"),
        ),
      ),
    );
  }
}
