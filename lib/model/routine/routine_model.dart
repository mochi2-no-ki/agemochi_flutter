// //ルーティーン情報のモデル
// import '../user/user_account.dart';
// import '../routine/tag.dart';

// //DB
// // class RoutineModel {
// //   final String routineId; //ルーティーンID
// //   final String userId; //作成者のユーザー
// //   final String routineTitle; //ルーティーンのタイトル
// //   final DateTime routineStart; //ルーティーンの開始時間
// //   final DateTime routineEnd; //ルーティーンの終了時間
// //   final int routineTime; //確認:UnsignedInt ルーティーンの所要時間(分)
// //   final String routineBody; //確認:Text ルーティーン内容
// //   final bool realtimeRoutineFlag; //リアルタイムルーティーン可能かどうか
// //   final DateTime createAt; //作成日時
// //   final DateTime? updateAt; //更新日時
// //   final DateTime? deleteAt; //削除日時

// //   RoutineModel({
// //     required this.routineId,
// //     required this.userId,
// //     required this.routineTitle,
// //     required this.routineStart,
// //     required this.routineEnd,
// //     required this.routineTime,
// //     required this.routineBody,
// //     required this.realtimeRoutineFlag,
// //     required this.createAt,
// //     required this.updateAt,
// //     required this.deleteAt,
// //   });
// // }

// class RoutineCardModel {
//   final String routineId;
//   final String routineTitle;
//   final int routineTime;
//   final List<TagModel> tags;
//   final UserAccountModel user;
//   final int referenceCount;
//   final int routineSaveCount;

//   RoutineCardModel({
//     required this.routineId,
//     required this.routineTitle,
//     required this.routineTime,
//     required this.tags,
//     required this.user,
//     required this.referenceCount,
//     required this.routineSaveCount,
//   });
// }
