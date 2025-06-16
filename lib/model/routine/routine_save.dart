class RoutineSave {
  final String routineSaveId; //ルーティーン保存ID
  final String userId; //ユーザーID
  final String routineId; //ルーティーンID
  final DateTime createAt; // 作成日時

  RoutineSave({
    required this.routineSaveId,
    required this.userId,
    required this.routineId,
    required this.createAt,
  });
}
