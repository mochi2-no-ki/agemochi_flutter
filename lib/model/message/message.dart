//message

class Message {
  final String messageId; //リアルタイムルーティーンのメッセージID
  final String userId; //送信者のユーザー
  final String messageTypeId; //メッセージ種類のID
  final String messageBody; //メッセージ本文
  final String replyUserId; //返信相手のユーザーID
  final DateTime createdAt; //作成日時

  Message({
    required this.messageId,
    required this.userId,
    required this.messageTypeId,
    required this.messageBody,
    required this.replyUserId,
    required this.createdAt,
  });
}
