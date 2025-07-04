import '../user/user_Info.dart';

class RoutineListResponse {
  final int code;
  final String message;
  final List<RoutineCardModel> routines;

  RoutineListResponse({
    required this.code,
    required this.message,
    required this.routines,
  });

  factory RoutineListResponse.fromJson(Map<String, dynamic> json) {
    return RoutineListResponse(
      code: json['code'],
      message: json['message'],
      routines: (json['data']['routines'] as List)
          .map((e) => RoutineCardModel.fromJson(e))
          .toList(),
    );
  }
}

class RoutineCardModel {
  final String routineId;
  final String routineTitle;
  final int routineTime;
  final List<String> tags;
  final UserInfoModel user;
  final int referenceCount;
  final int routineSaveCount;

  RoutineCardModel({
    required this.routineId,
    required this.routineTitle,
    required this.routineTime,
    required this.tags,
    required this.user,
    required this.referenceCount,
    required this.routineSaveCount,
  });

  factory RoutineCardModel.fromJson(Map<String, dynamic> json) {
    return RoutineCardModel(
      routineId: json['routine_id'],
      routineTitle: json['routine_title'],
      routineTime: json['routine_time'],
      tags: (json['tags'] as List)
          .map((tag) => tag['tag_name'] as String)
          .toList(),
      user: UserInfoModel.fromJson(json['user']),
      referenceCount: json['reference_count'],
      routineSaveCount: json['routine_save_count'],
    );
  }
}
