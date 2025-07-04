//リアルタイムルーティーン画面

//TODO:API
import '../../testData/user_test.dart';
// import 'package:agemoti/view/components/userInfo.dart';
import 'package:flutter/material.dart';

import 'package:agemoti/model/message/message.dart';
// import '../../testData/routine_test.dart';
import 'package:agemoti/testData/realtime_routine_controller.dart';
import 'package:agemoti/testData/realtime_routine_participants_controller.dart';
import 'package:agemoti/testData/message_controller.dart';
// import '../../model/routine/routine_model.dart';

class RealtimeRoutine extends StatefulWidget {
  RealtimeRoutine({super.key});

  @override
  State<RealtimeRoutine> createState() => _RealtimeRoutineState();
}

class _RealtimeRoutineState extends State<RealtimeRoutine> {
  final UserTest _myprofileController = UserTest();
  final UserTest _userController = UserTest();
  // final CardController _routineController = CardController();
  final RealtimeRoutineController _realtimeroutineController =
      RealtimeRoutineController();
  final RealtimeRoutineParticipantsController _participantsController =
      RealtimeRoutineParticipantsController();

  final TextEditingController _textEditingController = TextEditingController();

  final MessageController _messageController = MessageController();

  final List<String> myMessages = [];

  @override
  void initState() {
    super.initState();
    // 今後API取得処理をここに記述予定
  }

  @override
  Widget build(BuildContext context) {
    //確認：
    // ーーーーーーーー仮データ取得ーーーーーーーーー
    // 自分の情報取得
    final profile_user = _myprofileController.posts;
    // 参加するルーティーンの情報を取得
    final target_rr = _realtimeroutineController.realtimeRoutine
        .firstWhere((r) => r.realtimeRoutineId == 'b1-rr-1');
    // 主催者の情報を取得
    final owner = _userController.userController
        .firstWhere((u) => u.userId == target_rr.ownerUserId);
    // 参加者の情報を取得
    final participants = _participantsController.rr_participants
        .where((p) => p.realtimeRoutineId == target_rr.realtimeRoutineId)
        // .map((p) => _userController.userController.firstWhere(
        //     (u) => u.userId == p.userId,
        //     orElse: () => UserAccountModel.fallback(p.userId)))
        .map((p) => _userController.userController
            .firstWhere((u) => u.userId == p.userId))
        .toList();
    // メッセージ情報取得
    final messages = _messageController.message;

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ルーティーンタイトル表示
              Center(
                  child: Text(target_rr.realtimeRoutineTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ))),
              // 主催者情報表示
              const SizedBox(height: 20),
              Row(children: [
                const Text('主催者', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                CircleAvatar(radius: 24, child: Image.asset(owner.userImgPath)),
                const SizedBox(width: 8),
                Text(owner.mochiId, style: const TextStyle(fontSize: 18))
              ]),
              // 参加者情報表示
              const SizedBox(height: 20),
              Row(children: [
                const Text('参加者', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // 自分（profile_user）のアイコン
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: CircleAvatar(
                            radius: 20,
                            child: Image.asset(profile_user.userImgPath),
                          ),
                        ),
                        // 自分、主催者を除く参加者たち
                        ...participants.map((u) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: CircleAvatar(
                                radius: 20,
                                // TODO:child: Image.asset(u.),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ]),
              // 開始時間
              const SizedBox(height: 20),
              Row(children: [
                const Text('開始時間', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 20),
                Text(
                    '${target_rr.startTime.hour}：${target_rr.startTime.minute.toString().padLeft(2, '0')} ~',
                    style: const TextStyle(fontSize: 18))
              ]),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  target_rr.realtimeStatusId == '1'
                      ? 'よろしくタイム'
                      : target_rr.realtimeStatusId == '2'
                          ? '参加中'
                          : target_rr.realtimeStatusId == '3'
                              ? 'ありがとうタイム'
                              : '',
                  style:
                      const TextStyle(fontSize: 22, color: Colors.deepOrange),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.userId == profile_user.userId;
                    final isOwner = msg.userId == owner.userId;
                    final user = isMe
                        ? profile_user
                        : isOwner
                            ? owner
                            : participants.firstWhere(
                                (u) => u.userId == msg.userId,
                              );

                    if (isMe) {
                      // 自分のメッセージ：右側に表示
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromARGB(255, 209, 78, 47)),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Text(msg.messageBody,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      );
                    } else {
                      // 他者のメッセージ：左側に表示
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                  radius: 20,
                                  child: Image.asset(profile_user.userImgPath)),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.mochiId,
                                  style: const TextStyle(fontSize: 14)),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(12),
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 209, 78, 47)),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                    )
                                  ],
                                ),
                                child: Text(msg.messageBody,
                                    style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      //メッセージ送信エリア
      bottomNavigationBar: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 48), // 下に24の余白
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
                    _messageController.message.add(
                      Message(
                        messageId: DateTime.now()
                            .millisecondsSinceEpoch
                            .toString(), // 一時的なID
                        userId: profile_user.userId,
                        messageTypeId: '1',
                        messageBody: text,
                        replyUserId: '',
                        createdAt: DateTime.now(),
                      ),
                    );
                  });
                  _textEditingController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
