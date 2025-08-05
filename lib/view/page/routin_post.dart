import 'package:flutter/material.dart';
import '../../const/color.dart';
import '../../const/dimens.dart';
import '../components/elevatedButton.dart';
import '../components/field.dart';
import '../components/search.dart';
import '../../api/routine/routine_post.dart';
import '../../model/routine/routine_tag.dart';
import '../../testData/user_test.dart';
import '../../model/user/user_Info.dart';

import '../../view/components/userInfo.dart';

class RoutinePost extends StatefulWidget {
  const RoutinePost({
    super.key,
  });

  @override
  State<RoutinePost> createState() => _RoutinePostState();
}

class _RoutinePostState extends State<RoutinePost> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TextEditingController _bodyController = TextEditingController(); //本文
    bool _realtimeFlag = false; //RRスイッチ
    TimeOfDay? _startTime;
    TimeOfDay? _endTime;
    int? _duration;

    List<TagModel> _selectedTags = [];

    void _addTag(TagModel tag) {
      if (_selectedTags.length >= 3) return;
      if (_selectedTags.any((t) => t.tagId == tag.tagId)) return;
      setState(() {
        _selectedTags.add(tag);
      });
    }

    List<String> timeDurations = [
      '00:30',
      '00:45',
      '01:00',
      '01:15',
      '01:30',
      '01:45',
      '02:00'
    ];

    //時間帯選択肢
    List<String> timeSlots = List.generate(
      96,
      (index) =>
          '${(index ~/ 4).toString().padLeft(2, '0')}:${(index % 4 * 15).toString().padLeft(2, '0')}',
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08), // 高さを指定

        child: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorConst.bt,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 10, top: 10),
                child: ButtonComponents(
                  label: '投稿',
                  onPressed: () async {
                    //   try {
                    //     final routineId = await postRoutine(
                    //       userId: "ユーザーのUUID", // TODO: 実際のユーザーIDを入れる
                    //       title: _titleController.text,
                    //       startTime: "10:00", // TODO: 実際の値と連携
                    //       endTime: "11:30", // TODO: 実際の値と連携
                    //       timeMinutes: 90, // TODO: 実際の値と連携
                    //       body: "本文", // TODO: 実際のテキストコントローラを追加
                    //       realtimeFlag: true, // TODO: スイッチの状態から取得
                    //       tagIds: ["1", "3"], // TODO: 選択されたタグから取得
                    //     );

                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text("投稿成功！ID: $routineId")),
                    //     );
                    //     Navigator.pop(context);
                    //   } catch (e) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text("投稿失敗: $e")),
                    //     );
                    //   }
                  },
                ))
          ],
          backgroundColor: ColorConst.bk,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width * 0.8,
                // child: UserInfo(post: )
              ),
              VerticalSpacer(ratio: 0.01),

              TextFieldComponents(
                controller: _titleController,
                hintText: 'Title',
                fontsize: 40,
              ),
              VerticalSpacer(ratio: 0.01),

              //確認:Rowにしたらtagが長いとき、折り返されてUIが崩れるためColumnに変更
              Container(
                alignment: Alignment.center,
                width: width * 0.8,
                child: Column(
                  children: _selectedTags
                      .map((tag) => Column(
                            children: [
                              TagFieldComponents(tagname: tag.tagName),
                              const VerticalSpacer(ratio: 0.01),
                            ],
                          ))
                      .toList(),
                ),
              ),
              VerticalSpacer(ratio: 0.01),

              Container(
                  width: width * 0.6,
                  child: SearchBarComponents(
                    onTagSelected: _addTag,
                    onSearch: (keyword) {
                      setState(() {});
                    },
                  )

                  // SearchBarComponents(
                  //   onTagSelected: _addTag,
                  // ),
                  ),
              VerticalSpacer(),

              Container(
                child: SwitchComponents(
                  value: _realtimeFlag,
                  onChanged: (val) {
                    setState(() {
                      _realtimeFlag = val;
                    });
                  },
                ),
              ),
              VerticalSpacer(),

              // Container(
              //   child: TimePickerComponenets(
              //     icon: Icons.timer,
              //     lavel: '所要時間',
              //   ),
              // ),
              // VerticalSpacer(),
              // Container(
              //   child: TimePickerComponenets(
              //     icon: Icons.av_timer_outlined,
              //     lavel: '時間帯',
              //   ),
              // ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('所要時間'),
                    const Icon(
                      Icons.timer_outlined,
                      color: Colors.deepOrange,
                    ),
                    DropdownButton<String>(
                      hint: const Text('選択してください'),
                      onChanged: (value) {
                        setState(() {
                          // selectedTime = value;
                        });
                      },
                      items: timeDurations
                          .map(
                              (t) => DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                    ),
                  ],
                ),
              ),

              //時間帯
              SizedBox(height: height * 0.01),
              Container(
                alignment: Alignment.center,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text('時間帯　'),
                  const Icon(
                    Icons.watch_later_outlined,
                    color: Colors.deepOrange,
                  ),
                  Row(
                    children: [
                      const Text('開始: '),
                      DropdownButton<String>(
                        // value: selectedStartTime,
                        hint: const Text('選択'),
                        onChanged: (value) {
                          setState(() {
                            // selectedStartTime = value;
                          });
                        },
                        items: timeSlots
                            .map((t) =>
                                DropdownMenuItem(value: t, child: Text(t)))
                            .toList(),
                      ),
                      SizedBox(width: width * 0.02),
                      const Text('終了: '),
                      DropdownButton<String>(
                        // value: selectedEndTime,
                        hint: const Text('選択'),
                        onChanged: (value) {
                          setState(() {
                            // selectedEndTime = value;
                          });
                        },
                        items: timeSlots
                            .map((t) =>
                                DropdownMenuItem(value: t, child: Text(t)))
                            .toList(),
                      ),
                    ],
                  ),
                ]),
              ),
              VerticalSpacer(),
              Container(
                width: width * 0.8,
                child: TextFieldComponents(
                  controller: _bodyController,
                  hintText: '本文を入力してください',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
