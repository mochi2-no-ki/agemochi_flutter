class RealtimeStatus {
  final String realtimeStatusId; //リアルタイムルーティーンの状態ID
  final String realtimeStatus; //リアルタイムルーティーンの状態
  final DateTime createAt; //作成日時
  final DateTime updateAt; //更新日時
  final DateTime deleteAt; //削除日時

  RealtimeStatus({
    required this.realtimeStatusId,
    required this.realtimeStatus,
    required this.createAt,
    required this.updateAt,
    required this.deleteAt,
  });
}
