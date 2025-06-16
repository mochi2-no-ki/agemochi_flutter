//[test]ユーザー情報

import 'package:flutter/cupertino.dart';

import '../model/user/user_account.dart';

class MyprofileController {
  final UserAccountModel posts = UserAccountModel(
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
  final List<UserAccountModel> _posts = [
    UserAccountModel(
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
    UserAccountModel(
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
  List<UserAccountModel> get userController => _posts;
}
