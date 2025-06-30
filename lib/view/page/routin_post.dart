import 'package:flutter/material.dart';
import '../components/userInfo.dart';
import '../../const/color.dart';
import '../../const/dimens.dart';
import '../../model/user/user_account.dart';
import '../components/elevatedButton.dart';
import '../components/field.dart';

class RoutinePost extends StatefulWidget {
  final UserAccountModel myAccount;

  const RoutinePost({super.key, required this.myAccount});

  @override
  State<RoutinePost> createState() => _RoutinePostState();
}

class _RoutinePostState extends State<RoutinePost> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                padding: EdgeInsets.only(right: 20, top: 20),
                child: ButtonComponents(
                    label: '投稿',
                    onPressed: () {
                      //TODO:処理
                    }))
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
                child: MyInfo(myAccount: widget.myAccount),
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
                child: const Column(
                  children: [
                    //TODO:ここ編集する
                    TagFieldComponents(tagname: ''),
                    VerticalSpacer(ratio: 0.01),
                    TagFieldComponents(tagname: ''),
                    VerticalSpacer(ratio: 0.01),
                    TagFieldComponents(tagname: ''),
                  ],
                ),
              ),
              VerticalSpacer(ratio: 0.01),

              Container(
                width: width * 0.6,
                child: SearchBarComponents(),
              ),
              VerticalSpacer(),

              Container(
                child: SwitchComponents(),
              ),
              VerticalSpacer(),

              Container(
                child: TimePickerComponenets(
                  icon: Icons.timer,
                  lavel: '所要時間',
                ),
              ),
              VerticalSpacer(),
              Container(
                child: TimePickerComponenets(
                  icon: Icons.av_timer_outlined,
                  lavel: '時間帯',
                ),
              ),
              VerticalSpacer(),
              Container(
                width: width * 0.8,
                child: TextFieldComponents(
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
