//[test]:リアルタイムルーティーン
import '../model/realtime_routine/realtime_routine.dart';

class RealtimeRoutineController {
  final List<RealtimeRoutine> _rr = [
    RealtimeRoutine(
      realtimeRoutineId: 'a1-rr-1',
      routineId: 'a1-1',
      ownerUserId: 'a1',
      realtimeRoutineTitle: 'お散歩しませんか',
      startTime: DateTime.parse("2025-06-27T18:00:00"),
      endTime: DateTime.parse("2025-06-27T19:00:00"),
      actualEndTime: DateTime.parse("2025-06-27T19:30:00"),
      realtimeStatusId: '2',
      createAt: DateTime.parse("2025-06-27"),
      updateAt: DateTime.parse("2025-06-27"),
    ),
    RealtimeRoutine(
      realtimeRoutineId: 'a1-rr-2',
      routineId: 'a1-2',
      ownerUserId: 'a1',
      realtimeRoutineTitle: '筋トレしましょう',
      startTime: DateTime.parse("2025-06-27T18:00:00"),
      endTime: DateTime.parse("2025-06-27T19:00:00"),
      actualEndTime: DateTime.parse("2025-06-27T19:30:00"),
      realtimeStatusId: '2',
      createAt: DateTime.parse("2025-06-27"),
      updateAt: DateTime.parse("2025-06-27"),
    ),
    RealtimeRoutine(
      realtimeRoutineId: 'b1-rr-1',
      routineId: 'b1-1',
      ownerUserId: 'b1',
      realtimeRoutineTitle: '基本情報の勉強',
      startTime: DateTime.parse("2025-06-27T18:00:00"),
      endTime: DateTime.parse("2025-06-27T19:00:00"),
      actualEndTime: DateTime.parse("2025-06-27T19:30:00"),
      realtimeStatusId: '1',
      createAt: DateTime.parse("2025-06-27"),
      updateAt: DateTime.parse("2025-06-27"),
    ),
    RealtimeRoutine(
      realtimeRoutineId: 'c1-rr-1',
      routineId: 'c1-1',
      ownerUserId: 'c1',
      realtimeRoutineTitle: 'にんじん生活',
      startTime: DateTime.parse("2025-06-27T18:00:00"),
      endTime: DateTime.parse("2025-06-27T19:00:00"),
      actualEndTime: DateTime.parse("2025-06-27T19:30:00"),
      realtimeStatusId: '1',
      createAt: DateTime.parse("2025-06-27"),
      updateAt: DateTime.parse("2025-06-27"),
    ),
  ];

  List<RealtimeRoutine> get realtimeRoutine => _rr;
}
