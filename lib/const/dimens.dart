import 'package:flutter/material.dart';

//size調整
class HorizontalSpacer extends StatelessWidget {
  final double ratio;

  const HorizontalSpacer({this.ratio = 0.05, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(width: width * ratio);
  }
}
