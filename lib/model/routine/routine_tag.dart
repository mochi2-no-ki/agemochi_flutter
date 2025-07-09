///ルーティーンで表示するタグ
class RoutineTagModel {
  final String routineTagId;
  final String routineId;
  final String tagId;
  final DateTime createAt;

  RoutineTagModel({
    required this.routineTagId,
    required this.routineId,
    required this.tagId,
    required this.createAt,
  });
  factory RoutineTagModel.fromJson(Map<String, dynamic> json) {
    return RoutineTagModel(
      routineTagId: json['routine_tag_id'] as String,
      routineId: json['routine_id'] as String,
      tagId: json['tag_id'] as String,
      createAt: json['create_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'routine_tag_id': routineTagId,
      'routine_id': routineId,
      'tag_id': tagId,
      'create_at': createAt,
    };
  }
}

///tag検索のレスポンス
class TagResponse {
  final int code;
  final String message;
  final TagData data;

  TagResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory TagResponse.fromJson(Map<String, dynamic> json) {
    return TagResponse(
      code: json['code'],
      message: json['message'],
      data: TagData.fromJson(json['data']),
    );
  }
}

class TagData {
  final List<TagModel> tags;

  TagData({required this.tags});

  factory TagData.fromJson(Map<String, dynamic> json) {
    final tagList = json['tags'] as List<dynamic>;
    return TagData(
      tags: tagList.map((e) => TagModel.fromJson(e)).toList(),
    );
  }
}

class TagModel {
  final String tagId;
  final String tagName;

  TagModel({required this.tagId, required this.tagName});

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      tagId: json['tag_id'],
      tagName: json['tag_name'],
    );
  }
}
