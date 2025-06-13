//PAGE:main
import 'package:flutter/material.dart';

import 'view/page/home.dart';
import 'const/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'agemochi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: ColorConst.bk,
      ),
      home: Home(),
    );
  }
}
