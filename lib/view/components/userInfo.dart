//ユーザーアイコン userID username

import 'package:flutter/material.dart';
import '../../testData/user_controller.dart';
import '../../model/user/user_account.dart';

class UserInfo extends StatelessWidget {
  final UserModel post;
  final int index;

  UserInfo({
    super.key,
    required this.index,
    required post,
  }) : post = post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: post.userImgPath,
        ),
        Column(
          children: [
            Text(post.userName),
            Text(post.mochiId),
          ],
        ),
      ],
    );
  }
}
