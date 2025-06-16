class MessageType {
  final String messageTypeId;
  final String messageType;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime deleteAt;

  MessageType({
    required this.messageTypeId,
    required this.messageType,
    required this.createAt,
    required this.updateAt,
    required this.deleteAt,
  });
}
