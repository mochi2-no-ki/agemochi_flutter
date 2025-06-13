//[test]ユーザー情報

import 'package:flutter/cupertino.dart';

import '../model/user/user_account.dart';

class MyprofileController {
  final UserModel posts = UserModel(
    userId: 'a1',
    mochiId: 'miumiu',
    userName: 'ちゃんみー',
    userImgPath: Image.asset('icon/icon2.png'),
    introduction: const Text('よろしくお願いいたします！'),
    currentUserBannerId: 'currentUserBannerId',
    currentIconFrameId: 'currentIconFrameId',
    createdAt: DateTime(2025, 06, 21),
    updatedAt: DateTime(2025, 06, 28),
  );
}

class UserController {
  final List<UserModel> _posts = [
    UserModel(
      userId: 'b1',
      mochiId: 'ta_ma',
      userName: '玉子',
      userImgPath: Image.asset('icon/icon1.png'),
      introduction: const Text('よろしく！'),
      currentUserBannerId: 'currentUserBannerId',
      currentIconFrameId: 'currentIconFrameId',
      createdAt: DateTime(2025, 06, 21),
      updatedAt: DateTime(2025, 06, 29),
    ),
    UserModel(
      userId: 'c1',
      mochiId: 'hare_hare',
      userName: '太陽',
      userImgPath: Image.asset('icon/icon3.png'),
      introduction: const Text('頑張りまーす'),
      currentUserBannerId: 'currentUserBannerId',
      currentIconFrameId: 'currentIconFrameId',
      createdAt: DateTime(2025, 07, 21),
      updatedAt: DateTime(2025, 07, 29),
    ),
  ];
  List<UserModel> get userController => _posts;
}
