//ユーザーアイコン userID username

import 'package:flutter/material.dart';
import '../../model/routine/routine_model.dart';

class UserInfo extends StatelessWidget {
  final RoutineCardModel post;

  const UserInfo({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('${post.user.userImgPath}'),
      title: Text(post.user.userName),
      subtitle: Text('@${post.user.mochiId}'),
    );
  }
}
