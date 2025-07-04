//ルーティーン詳細
import 'package:agemoti/view/components/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../const/color.dart';
import '../../const/dimens.dart';
import '../components/elevatedButton.dart';
import '../components/field.dart';
import '../../model/routine/routine_detail.dart';

class RoutineDetail extends StatefulWidget {
  const RoutineDetail({
    super.key,
  });

  @override
  State<RoutineDetail> createState() => _RoutineDetailState();
}

class _RoutineDetailState extends State<RoutineDetail> {
  final TextEditingController _titleController = TextEditingController();
  RoutineDetailModel? routine;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRoutineDetail();
  }

  Future<void> fetchRoutineDetail() async {
    final url = Uri.parse(
        'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/routine/01979b96-757b-7c70-b405-4d46c91a4f04/detail');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("UI画面200!!!!!!!!!!!!");
      final jsonData = jsonDecode(response.body);
      final data = RoutineDetailModel.fromJson(jsonData['data']);
      setState(() {
        routine = data;
        isLoading = false;
      });
    } else {
      print("API取得失敗: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (routine == null) {
      // API取得失敗やnullの場合の表示
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
                  width: width * 0.8, child: UserInfo(post: routine!.user)),
              const VerticalSpacer(ratio: 0.01),

              Text(
                routine!.routineTitle,
                style: const TextStyle(fontSize: 40),
              ),
              const VerticalSpacer(),

              //確認:Rowにしたらtagが長いとき、折り返されてUIが崩れるためColumnに変更
              Container(
                alignment: Alignment.center,
                width: width * 0.8,
                child: const Column(
                  children: [
                    //TODO:ここ編集する
                    TagFieldComponents(tagname: 'tag'),
                    VerticalSpacer(ratio: 0.01),
                    TagFieldComponents(tagname: 'tag'),
                    VerticalSpacer(ratio: 0.01),
                    TagFieldComponents(tagname: 'tag'),
                  ],
                ),
              ),
              const VerticalSpacer(),

              Container(
                // child: TimePickerComponenets(
                //   icon: Icons.timer,
                //   lavel: '所要時間',
                // ),
                child: Text(routine!.routineTime.toString()),
              ),
              const VerticalSpacer(),
              Container(
                child: TimePickerComponenets(
                  icon: Icons.av_timer_outlined,
                  lavel: '時間帯',
                ),
              ),
              const VerticalSpacer(),
              Container(
                width: width * 0.8,
                child: Text(
                  routine!.routineBody,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
