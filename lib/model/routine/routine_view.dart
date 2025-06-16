import 'dart:ffi';

class RoutineView {
  final String routineId; //ルーティーンID
  final UnsignedInt referenceCount; //参考になったリアクションのカウント
  final UnsignedInt viewCount; //閲覧数カウント
  final DateTime createAt; //  作成日時
  final DateTime updateAt; //更新日時

  RoutineView({
    required this.routineId,
    required this.referenceCount,
    required this.viewCount,
    required this.createAt,
    required this.updateAt,
  });
}
