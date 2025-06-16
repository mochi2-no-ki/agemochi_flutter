//routine_tag

class RoutineTag {
  final String routineTagId; //ルーティーンタグID
  final String routineId; //ルーティーンID
  final String tagId; //タグID
  final DateTime createAt; //作成日時

  RoutineTag({
    required this.routineTagId,
    required this.routineId,
    required this.tagId,
    required this.createAt,
  });
}
