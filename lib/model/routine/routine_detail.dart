import 'package:flutter/material.dart';
import '../user/user_Info.dart';

class RoutineDetailModel {
  final String routineId;
  final String routineTitle;
  final String routineBody;
  final TimeOfDay routineStart;
  final TimeOfDay routineEnd;
  final int routineTime;
  final List<String> tags;
  final UserInfoModel user;
  final int referenceCount;
  final int routineSaveCount;
  final bool realtimeRoutineFlag;
  final DateTime createdAt;

  RoutineDetailModel({
    required this.routineId,
    required this.routineTitle,
    required this.routineBody,
    required this.routineStart,
    required this.routineEnd,
    required this.routineTime,
    required this.tags,
    required this.user,
    required this.referenceCount,
    required this.routineSaveCount,
    required this.realtimeRoutineFlag,
    required this.createdAt,
  });
  factory RoutineDetailModel.fromJson(Map<String, dynamic> json) {
    return RoutineDetailModel(
      routineId: json['routine_id'],
      routineTitle: json['routine_title'],
      routineBody: json['routine_body'],
      routineStart: _parseTimeOfDay(json['routine_start']),
      routineEnd: _parseTimeOfDay(json['routine_end']),
      routineTime: json['routine_time'],
      tags: List<String>.from(json['tags'].map((tag) => tag['tag_name'])),
      user: UserInfoModel.fromJson(json['user']),
      referenceCount: json['reference_count'],
      routineSaveCount: json['routine_save_count'],
      realtimeRoutineFlag: json['realtime_routine_flag'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

TimeOfDay _parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  return TimeOfDay(
    hour: int.parse(parts[0]),
    minute: int.parse(parts[1]),
  );
}
