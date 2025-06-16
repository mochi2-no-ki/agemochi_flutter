class RealtimeRoutine {
  final String realtimeRoutineId; //開催ルーティーンID
  final String routineId; //参照元ルーティーンID
  final String ownerUserId; //開催者ユーザID
  final String realtimeRoutineTitle; //title
  final DateTime startTime; //開始時刻
  final DateTime endTime; //終了予定時刻
  final DateTime actualEndTime; //実際の終了時刻
  final String realtimeStatusId; //リアルタイムルーティーンの状態ID
  final DateTime createAt; //作成日時
  final DateTime updateAt; //更新日時

  RealtimeRoutine({
    required this.realtimeRoutineId,
    required this.routineId,
    required this.ownerUserId,
    required this.realtimeRoutineTitle,
    required this.startTime,
    required this.endTime,
    required this.actualEndTime,
    required this.realtimeStatusId,
    required this.createAt,
    required this.updateAt,
  });
}
