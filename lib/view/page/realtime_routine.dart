//リアルタイムルーティーン画面
import 'package:flutter/material.dart';

///const
import 'package:agemoti/const/color.dart';

///component
import 'package:agemoti/view/components/userInfo.dart';
import '../components/field.dart';

///model
import '../../model/routine/routine_detail.dart';
import '../../model/message/message.dart';
import '../../model/user/user_Info.dart';

///api
import '../../api/realtime_routine/chatHistory.dart';
import '../../api/realtime_routine/participantId.dart';
import '../../api/realtime_routine/rr_id.dart';

///testdata
import '../../testData/user_test.dart';

class RealtimeRoutine extends StatefulWidget {
  final RoutineDetailModel? routine;

  RealtimeRoutine({
    super.key,
    required this.routine,
  });

  @override
  State<RealtimeRoutine> createState() => _RealtimeRoutineState();
}

class _RealtimeRoutineState extends State<RealtimeRoutine> {
  final UserTests _userIcon = UserTests();
  final UserTest _myprofileController = UserTest();

  final TextEditingController _textEditingController = TextEditingController();
  late List<Message> chatMessages = [];
  List<UserInfoModel> participantUserList = [];

  @override
  void initState() {
    super.initState();
    _loadRealtimeRoutineAndParticipants();
  }

  Future<void> _loadRealtimeRoutineAndParticipants() async {
    try {
      final rrData = await fetchRRid(widget.routine!.routineId);
      final rrRoutineId = rrData['realtime_routine_id'];

      ///参加者の取得
      final participants = await fetchParticipantList(rrRoutineId);

      ///チャット履歴の取得
      final messages = await fetchChatHistory(
        '01979b96-757b-7c70-b405-4d46c91a4f04',
        offset: 0,
        mochiId: 'miumiu',
      );

      setState(() {
        participantUserList = participants; //参加者
        chatMessages = messages; //チャット
      });
    } catch (e) {
      print('エラー: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        child: AppBar(
          backgroundColor: ColorConst.bk,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorConst.bt,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(widget.routine!.routineTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(),
              const SizedBox(height: 20),
              Row(children: [
                Text(
                  '主催者',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: UserInfo(
                    post: widget.routine!.user,
                    testImg: 'assets/icon/icon9.png',
                    //下が正しい
                    // testImg: widget.routine!.user.userImgPath,
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(children: [
                const Text(
                  '参加者',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        //TODO:Test書き換える
                        UserIcon(img: UserTest().posts.userImgPath),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                        ),
                        //TODO:"assets//img/kuro.png"になってる
                        // ...participantUserList.map(
                        //   (icon) {
                        //     // return UserIcon(img: icon.userImgPath);
                        //   },
                        // ),
                        ..._userIcon.testUsers.map((icon) {
                          return UserIcon(img: icon.userImgPath);
                        })
                      ],
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 20),

              const TimePickerComponenets(
                icon: Icons.watch_later_outlined,
                lavel: '開始時間',
              ),
              const SizedBox(height: 20),
              //TODO:ほかの時間のconstも作る
              Center(
                child: Text(
                  'よろしくタイム',
                  style:
                      const TextStyle(fontSize: 22, color: Colors.deepOrange),
                ),
              ),
              const SizedBox(height: 20),

              ///メッセージ欄
              Expanded(
                child: ListView.builder(
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    final msg = chatMessages[index];
                    final isMe =
                        msg.mochiId == _myprofileController.posts.mochiId;
                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.orange[100] : ColorConst.chatYou,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft:
                                isMe ? const Radius.circular(16) : Radius.zero,
                            bottomRight:
                                isMe ? Radius.zero : const Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (msg.replyMochiId.isNotEmpty)
                              Text(
                                '↪ ${msg.replyMochiId}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[700]),
                              ),
                            Text(
                              msg.messageBody,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${msg.createdAt.hour}:${msg.createdAt.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 48),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'メッセージを入力',
                    filled: true,
                    fillColor: Colors.orange[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.orange),
                onPressed: () {
                  final text = _textEditingController.text.trim();
                  if (text.isNotEmpty) {
                    setState(() {
                      // 自分のuserIdを使って新しいメッセージを作成し、controllerに追加
                      // _messageController.message.add(
                      //   Message(
                      //     messageId: DateTime.now()
                      //         .millisecondsSinceEpoch
                      //         .toString(), // 一時的なID
                      //     userId: profile_user.userId,
                      //     messageTypeId: '1',
                      //     messageBody: text,
                      //     replyUserId: '',
                      //     createdAt: DateTime.now(),
                      //   ),
                      // );
                    });
                    _textEditingController.clear();
                  }
                },
              ),
            ],
          )),
    );
  }
}
