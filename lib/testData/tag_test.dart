//[test]タグのテストデータ

import '../model/routine/tag.dart';

class TagTest {
  final List<TagModel> _post = [
    TagModel(
      tagId: 'a1',
      tagName: '筋トレ',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'a2',
      tagName: '勉強',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'a3',
      tagName: '資格',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'a4',
      tagName: 'IT',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'a5',
      tagName: '家族',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'b1',
      tagName: '運動',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'b2',
      tagName: '癒し',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'b3',
      tagName: 'ゲーム',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'b4',
      tagName: '映画',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'b5',
      tagName: '健康',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
    TagModel(
      tagId: 'b6',
      tagName: 'お出かけ',
      createdAt: DateTime.parse("2025-06-03"),
      updatedAt: DateTime.parse("2025-06-03"),
    ),
  ];
  List<TagModel> get tagModel => _post;
}
