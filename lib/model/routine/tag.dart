//tag

class TagModel {
  final String tagId; //タグID
  final String tagName; //タグの名前
  final DateTime createdAt; //作成日時
  final DateTime? updatedAt; //更新日時
  final DateTime? deletedAt; //削除日時

  TagModel({
    required this.tagId,
    required this.tagName,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
