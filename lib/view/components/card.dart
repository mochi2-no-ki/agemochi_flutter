//ルーティーンカードコンポーネント

import 'package:flutter/material.dart';
import '../../const/color.dart'; //color const
import 'userInfo.dart'; //ユーザー情報のUI
import '../../model/routine/routine_card.dart';
import '../../const/dimens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../page/routine_details.dart';

class RoutineCard extends StatefulWidget {
  final RoutineCardModel post;
  final int index;

  RoutineCard({
    super.key,
    required this.index,
    required this.post,
  });

  @override
  State<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  RoutineCardModel? routine;
  bool isLoading = true;
  Future<List<RoutineCardModel>> fetchRoutineList() async {
    final url = Uri.parse(
        'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/routine/list');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final routineList = RoutineListResponse.fromJson(jsonData);
      return routineList.routines;
    } else {
      throw Exception('ルーティーン一覧の取得に失敗しました');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        // TODO: タップ時の処理
        print('詳細に飛びます！');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoutineDetail(),
          ),
        );
      },
      child: Card(
        color: ColorConst.card,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorConst.main,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: height * 0.5,
            width: width * 0.5,
            child: Column(
              children: [
                UserInfo(post: widget.post.user),
                Text(
                  widget.post.routineTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    children: [
                      ...widget.post.tags.map((tag) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '#',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: ColorConst.tag,
                              ),
                            ),
                            Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8), // タグ間のスペース
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    HorizontalSpacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.access_alarm_outlined,
                          color: ColorConst.main,
                        ),
                        Text("${widget.post.routineTime}"),
                      ],
                    ),
                    HorizontalSpacer(
                      ratio: 0.09,
                    ),
                    Icon(Icons.favorite_border),
                    HorizontalSpacer(),
                    Icon(Icons.bookmark_border),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
