class RealtimeRoutineParticipant {
  final String realtimeRoutimeParticipantId; //主キー
  final String realtimeRoutineId; //開催ルーティーンID
  final String userId; //参加ユーザーID
  final DateTime createdAt; //作成日時

  RealtimeRoutineParticipant({
    required this.realtimeRoutimeParticipantId,
    required this.realtimeRoutineId,
    required this.userId,
    required this.createdAt,
  });
}
