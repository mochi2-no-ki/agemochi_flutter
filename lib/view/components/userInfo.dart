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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Row(
        children: [
          Container(
            height: height * 0.05,
            width: width * 0.05,
            child: Image.asset(testImg),
          ),

          Column(
            children: [
              Text(
                post.userName,
                style: TextStyle(),
              ),
              Text('@${post.mochiId}'),
            ],
          ),

          // CircleAvatar(
          //   backgroundImage: NetworkImage(
          //     'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io${post.userImgPath}',
          //   ),
          // ),
        ],
      ),
    );
    // return ListTile(
    //   //TODO:写真入れ替える
    //   leading: Container(
    //       height: height * 0.08,
    //       width: width * 0.08,
    //       child: Image.asset(testImg)),
    //   // CircleAvatar(
    //   //   backgroundImage: NetworkImage(
    //   //     'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io${post.userImgPath}',
    //   //   ),
    //   // ),
    //   title: Text(
    //     post.userName,
    //     style: TextStyle(),
    //   ),
    //   subtitle: Text('@${post.mochiId}'),
    // );
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
      width: 40, // お好みのサイズに調整
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // 丸くしたい場合
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
