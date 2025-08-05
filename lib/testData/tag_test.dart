//tagのテストデータ

import '../model/routine/routine_tag.dart';

class TagList {
  static List<TagModel> tagTest = [
    TagModel(tagId: "tag1", tagName: "勉強"),
    TagModel(tagId: "tag2", tagName: "資格"),
    TagModel(tagId: "tag3", tagName: "IT"),
    TagModel(tagId: "tag4", tagName: "語学"),
    TagModel(tagId: "tag5", tagName: "読書"),
    TagModel(tagId: "tag6", tagName: "健康"),
    TagModel(tagId: "tag7", tagName: "フィットネス"),
    TagModel(tagId: "tag8", tagName: "習慣"),
  ];
  static List<TagModel> get post => tagTest;
}
