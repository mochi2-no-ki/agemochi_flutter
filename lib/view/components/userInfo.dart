//ユーザーアイコン userID username

import 'package:flutter/material.dart';
import '../../model/user/user_Info.dart';

class UserInfo extends StatelessWidget {
  final UserInfoModel post;

  const UserInfo({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //TODO:写真入れ替える
      leading: Image.asset('assets/icon/icon1.png'),
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
