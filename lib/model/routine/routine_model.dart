//ルーティーン情報のモデル

class RoutineModel {
  final String routineId; //ルーティーンID
  final String userId;
  final String routineTitle;
  final DateTime routineStart;
  final DateTime routineEnd;
  final int routineTime; //確認:UnsignedInt
  final String routineBody; //確認:Text
  final bool realtimeRoutineFlag;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime deleteAt;

  RoutineModel({
    required this.routineId,
    required this.userId,
    required this.routineTitle,
    required this.routineStart,
    required this.routineEnd,
    required this.routineTime,
    required this.routineBody,
    required this.realtimeRoutineFlag,
    required this.createAt,
    required this.updateAt,
    required this.deleteAt,
  });
}
