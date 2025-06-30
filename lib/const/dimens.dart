import 'package:flutter/material.dart';

//横
class HorizontalSpacer extends StatelessWidget {
  final double ratio;

  const HorizontalSpacer({this.ratio = 0.05, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(width: width * ratio);
  }
}

//縦
class VerticalSpacer extends StatelessWidget {
  final double ratio;

  const VerticalSpacer({this.ratio = 0.05, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(height: height * ratio);
  }
}
