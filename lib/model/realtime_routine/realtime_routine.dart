//リアルタイムルーティーンのIDを取得

import '../../model/routine/routine_detail.dart';

class RealtimeRoutineModel {
  final String realtimeRoutineId;
  final RoutineDetailModel routineId;

  RealtimeRoutineModel({
    required this.realtimeRoutineId,
    required this.routineId,
  });

  factory RealtimeRoutineModel.fromJson(Map<String, dynamic> json) {
    return RealtimeRoutineModel(
      realtimeRoutineId: json['realtime_routine_id'] as String,
      routineId: RoutineDetailModel.fromJson(json['routine_id']),
    );
  }
}
