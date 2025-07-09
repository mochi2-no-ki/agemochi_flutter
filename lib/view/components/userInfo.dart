//ユーザーアイコン userID username

import 'package:flutter/material.dart';

///model
import '../../model/user/user_Info.dart';

///基本的なuser情報の表示
//TODO:testImgを消す！
class UserInfo extends StatelessWidget {
  final UserInfoModel post;
  final String testImg;
  const UserInfo({
    super.key,
    this.testImg = "assets/icon/icon2.png",
    required this.post,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      //TODO:写真入れ替える
      leading: Image.asset(testImg),
      // CircleAvatar(
      //   backgroundImage: NetworkImage(
      //     'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io${post.userImgPath}',
      //   ),
      // ),
      title: Text(post.userName),
      subtitle: Text('@${post.mochiId}'),
    );
  }
}

/// ICONのみ表示
class UserIcon extends StatelessWidget {
  final String img;
  const UserIcon({
    super.key,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(img),
    );
  }
}
