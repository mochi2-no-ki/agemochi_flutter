//message

class MessageDB {
  final String messageId; //リアルタイムルーティーンのメッセージID
  final String userId; //送信者のユーザー
  final String messageTypeId; //メッセージ種類のID
  final String messageBody; //メッセージ本文
  final String replyUserId; //返信相手のユーザーID
  final DateTime createdAt; //作成日時

  MessageDB({
    required this.messageId,
    required this.userId,
    required this.messageTypeId,
    required this.messageBody,
    required this.replyUserId,
    required this.createdAt,
  });
}

class Message {
  final String mochiId;
  final String replyMochiId;
  final String messageBody;
  final DateTime createdAt;

  Message({
    required this.mochiId,
    required this.replyMochiId,
    required this.messageBody,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      mochiId: json['mochi_id'] ?? '',
      replyMochiId: json['reply_mochi_id'] ?? '',
      messageBody: json['message_body'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
