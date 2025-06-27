//ルーティーンカードコンポーネント

import 'package:flutter/material.dart';
import '../../const/color.dart'; //color const
import 'userInfo.dart'; //ユーザー情報のUI
import '../../model/routine/routine_model.dart';
import '../../const/dimens.dart';

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
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
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
              UserInfo(post: widget.post),
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
                        children: [
                          const Text(
                            '#',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: ColorConst.tag,
                            ),
                          ),
                          Text(tag.tagName),
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
    );
  }
}
