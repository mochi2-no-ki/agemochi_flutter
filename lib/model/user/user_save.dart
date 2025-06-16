//user_save

class UserSaveModel {
  final String userId; //ユーザーID
  final int routineSaveMax; //ルーティーンの最大保存数
  final int realtimeRoutineSaveMax; //リアルタイムルーティーンの最大保存数
  final DateTime createdAt; //作成日時
  final DateTime updatedAt; //更新日時

  UserSaveModel({
    required this.userId,
    required this.routineSaveMax,
    required this.realtimeRoutineSaveMax,
    required this.createdAt,
    required this.updatedAt,
  });
}
