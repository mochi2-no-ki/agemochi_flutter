//ルーティーン詳細
import 'package:flutter/material.dart';

///const
import '../../const/color.dart';
import '../../const/dimens.dart';

///component
import 'package:agemoti/view/components/userInfo.dart';
import '../components/field.dart';

///page
import '../page/realtime_routine.dart';

///model
import '../../model/routine/routine_detail.dart';

///api
import '../../api/routine/routine_detail.dart';

class RoutineDetail extends StatefulWidget {
  final String cardId;
  const RoutineDetail({
    super.key,
    required this.cardId,
  });

  // @override
  State<RoutineDetail> createState() => _RoutineDetailState();
}

class _RoutineDetailState extends State<RoutineDetail> {
  // final TextEditingController _titleController = TextEditingController();
  RoutineDetailModel? routine;
  String? rrID;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoutine();
  }

  Future<void> _loadRoutine() async {
    try {
      final data = await fetchRoutineDetail(widget.cardId);
      setState(() {
        routine = RoutineDetailModel.fromJson(data);
        isLoading = false;
      });
    } catch (e) {
      print('データ取得失敗: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    ///API取得失敗やnullの場合の表示
    if (routine == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.08),
          child: AppBar(
            backgroundColor: ColorConst.bk,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: ColorConst.bt),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: const Center(child: Text('データ取得中')),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
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
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${routine!.createdAt.year}/${routine!.createdAt.month}/${routine!.createdAt.day}',
                style: const TextStyle(color: Colors.black),
              ),
            )
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
                child: UserInfo(
                  post: routine!.user,
                  testImg: 'assets/icon/icon9.png',
                ),
              ),
              const VerticalSpacer(ratio: 0.01),
              Text(
                routine!.routineTitle,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VerticalSpacer(),
              Container(
                alignment: Alignment.center,
                width: width * 0.15,
                child: Column(
                  children: [
                    ...routine!.tags.map((tag) {
                      return Column(
                        children: [
                          TagFieldComponents(
                            tagname: tag,
                            fontSize: 20,
                          ),
                          const VerticalSpacer(ratio: 0.01),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const VerticalSpacer(),
              //TODO:ピッカー変える
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '所要時間　',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.timer_outlined,
                    color: Colors.deepOrange,
                  ),
                  Text(
                    '${routine!.routineTime.toString()}分',
                    style: TextStyle(
                      fontSize: 28,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const VerticalSpacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '時間帯　　',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.watch_later_outlined,
                    color: Colors.deepOrange,
                  ),
                  Column(
                    children: [
                      Text(
                        '開始  18:00',
                        style: TextStyle(
                          fontSize: 28,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '終了  19:30',
                        style: TextStyle(
                          fontSize: 28,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )

                  // Text('${routine!.routineStart.toString()}'),
                ],
              ),
              // Container(
              //   child: TimePickerComponenets(
              //     icon: Icons.av_timer_outlined,
              //     lavel: '時間帯',
              //   ),
              // ),
              const VerticalSpacer(),
              Container(
                width: width * 0.8,
                child: Text(
                  routine!.routineBody,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _joinButton(),
    );
  }

  Widget _joinButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RealtimeRoutine(routine: routine),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
        backgroundColor: ColorConst.bt,
        elevation: 3,
      ),
      child: const SizedBox(
        width: 64,
        height: 64,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '参加',
                style: TextStyle(
                  fontSize: 13,
                  color: ColorConst.swout,
                ),
              ),
              SizedBox(height: 2),
              Icon(
                Icons.local_fire_department_rounded,
                size: 26,
                color: ColorConst.swout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
