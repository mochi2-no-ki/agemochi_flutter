//[test]ユーザー情報

import 'package:flutter/cupertino.dart';

import '../model/user/user_account.dart';

class UserTest {
  //自分のアカウント
  final UserAccountModel posts = UserAccountModel(
    userId: 'a1',
    mochiId: 'miumiu',
    userName: 'ちゃんみー',
    userImgPath: 'assets/icon/icon2.png',
    introduction: const Text('よろしくお願いいたします！'),
    currentUserBannerId: 'currentUserBannerId',
    currentIconFrameId: 'currentIconFrameId',
    createdAt: DateTime(2025, 06, 21),
    updatedAt: DateTime(2025, 06, 28),
  );

  final List<UserAccountModel> _posts = [
    UserAccountModel(
      userId: 'b1',
      mochiId: 'ta_ma',
      userName: '玉子',
      userImgPath: 'icon/icon1.png',
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
      userImgPath: 'icon/icon3.png',
      introduction: const Text('頑張りまーす'),
      currentUserBannerId: 'currentUserBannerId',
      currentIconFrameId: 'currentIconFrameId',
      createdAt: DateTime(2025, 07, 21),
      updatedAt: DateTime(2025, 07, 29),
    ),
    UserAccountModel(
      userId: 'd1',
      mochiId: 'yuki_pika',
      userName: '雪',
      userImgPath: 'assets/icon/icon4.png',
      introduction: const Text('雪のように静かに燃えてます'),
      currentUserBannerId: 'currentUserBannerId',
      currentIconFrameId: 'currentIconFrameId',
      createdAt: DateTime(2025, 07, 01),
      updatedAt: DateTime(2025, 07, 10),
    ),
    UserAccountModel(
      userId: 'e1',
      mochiId: 'hana_bi',
      userName: '花火',
      userImgPath: 'icon/icon4.png',
      introduction: const Text('一瞬の輝きを全力で！'),
      currentUserBannerId: 'currentUserBannerId',
      currentIconFrameId: 'currentIconFrameId',
      createdAt: DateTime(2025, 06, 15),
      updatedAt: DateTime(2025, 06, 18),
    ),
    UserAccountModel(
      userId: 'f1',
      mochiId: 'nene_chan',
      userName: 'ねね',
      userImgPath: 'icon/icon4.png',
      introduction: const Text('癒し担当です〜'),
      currentUserBannerId: 'currentUserBannerId',
      currentIconFrameId: 'currentIconFrameId',
      createdAt: DateTime(2025, 05, 10),
      updatedAt: DateTime(2025, 06, 05),
    ),
  ];

  List<UserAccountModel> get userController => _posts;
  UserAccountModel get myController => posts;
}
