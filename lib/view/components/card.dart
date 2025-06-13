//ルーティーンカードコンポーネント

import 'package:flutter/material.dart';
import '../../const/color.dart'; //color const
import 'userInfo.dart'; //ユーザー情報のUI
import '../../model/routine/routine_model.dart';

class RoutineCard extends StatefulWidget {
  final RoutineModel post;
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
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
      color: ColorConst.card,
      child: SizedBox(
        height: height * 0.2,
        width: width * 0.5,
        child: Column(
          children: [
            Text(widget.post.routineTitle),
            Text("${widget.post.routineTime}"),
          ],
        ),
      ),
    );
  }
}


/**
 * // 表示用に整形（例: 16:00~18:00）

 * final String formattedRange =
    '${DateFormat.Hm().format(startTime)}~${DateFormat.Hm().format(endTime)}';
 */