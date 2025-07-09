//PAGE:main
import 'package:agemoti/model/user/user_Info.dart';
import 'package:flutter/material.dart';

import 'view/page/home.dart';
import 'const/color.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'testData/user_test.dart';

void main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  UserInfoModel post = UserTest().post;
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'agemochi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: ColorConst.bk,
      ),
      home: Home(post: post),
    );
  }
}
