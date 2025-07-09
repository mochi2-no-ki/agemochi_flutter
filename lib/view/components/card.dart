//ルーティーンカードコンポーネント
import 'package:flutter/material.dart';
import 'dart:math';

///const
import '../../const/color.dart';
import '../../const/dimens.dart';

///component
import 'userInfo.dart';
import '../components/field.dart';

///page
import '../page/routine_details.dart';

///model
import '../../model/routine/routine_card.dart';

///testdata
import '../../testData/user_test.dart';

class RoutineCard extends StatefulWidget {
  final RoutineCardModel post;
  final int index;

  const RoutineCard({
    super.key,
    required this.index,
    required this.post,
  });
  @override
  State<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  final UserTests _userIcon = UserTests();
  late String randomImgPath;

  @override
  void initState() {
    super.initState();
    randomImgPath = _userIcon
        .testUsers[Random().nextInt(_userIcon.testUsers.length)].userImgPath;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoutineDetail(
              cardId: widget.post.routineId,
            ),
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
            // border: Border.all(
            //   color: ColorConst.main,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: height * 0.5,
            width: width * 0.3,
            child: Column(
              children: [
                UserInfo(
                  post: widget.post.user,
                  testImg: randomImgPath,
                ),
                Text(
                  widget.post.routineTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const VerticalSpacer(ratio: 0.01),
                SizedBox(
                  width: width * 0.3,
                  child: Column(
                    children: [
                      ...widget.post.tags.map((tag) {
                        return Row(
                          children: [
                            TagFieldComponents(
                              tagname: tag,
                              fontSize: 13,
                            ),
                            const VerticalSpacer(ratio: 0.01),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const HorizontalSpacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_alarm_outlined,
                          color: ColorConst.main,
                        ),
                        Text("${widget.post.routineTime}"),
                      ],
                    ),
                    const HorizontalSpacer(ratio: 0.09),
                    const Icon(Icons.favorite_border),
                    const HorizontalSpacer(),
                    const Icon(Icons.bookmark_border),
                  ],
                ),
                const VerticalSpacer(ratio: 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
