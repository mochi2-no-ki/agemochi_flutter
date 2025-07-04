//[test]メッセージ

import '../model/message/message.dart';

class MessageController {
  final List<Message> _message = [
    Message(
      messageId: '1',
      userId: 'c1',
      messageTypeId: '1',
      messageBody: 'よろしくお願いします！',
      replyUserId: '',
      createdAt: DateTime.parse("2025-06-27"),
    ),
    Message(
      messageId: '2',
      userId: 'd1',
      messageTypeId: '1',
      messageBody: '参加します',
      replyUserId: '',
      createdAt: DateTime.parse("2025-06-27"),
    ),
    Message(
      messageId: '3',
      userId: 'a1',
      messageTypeId: '1',
      messageBody: '一緒に頑張りましょう',
      replyUserId: '',
      createdAt: DateTime.parse("2025-06-27"),
    ),
    Message(
      messageId: '4',
      userId: 'b1',
      messageTypeId: '1',
      messageBody: '頑張ります！',
      replyUserId: '',
      createdAt: DateTime.parse("2025-06-27"),
    ),
  ];

  List<Message> get message => _message;
}
