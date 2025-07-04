//[test]:投稿
import '../model/routine/routine_model.dart';

class RoutineController {
  final List<RoutineModel> _post = [
    RoutineModel(
      routineId: 'a1-1',
      userId: 'a1',
      routineTitle: 'お散歩しませんか',
      routineStart: DateTime.parse("2025-06-03T16:00:00"),
      routineEnd: DateTime.parse("2025-06-03T18:00:00"),
      routineTime: 1,
      routineBody: 'data',
      realtimeRoutineFlag: true,
      createAt: DateTime.parse("2025-06-03"),
      updateAt: DateTime.parse("2025-06-03"),
      deleteAt: DateTime.parse("2025-06-03"),
    ),
    RoutineModel(
      routineId: 'a1-2',
      userId: 'a1',
      routineTitle: '筋トレしましょう',
      routineStart: DateTime.parse("2025-06-03T16:00:00"),
      routineEnd: DateTime.parse("2025-06-03T18:00:00"),
      routineTime: 1,
      routineBody: 'data',
      realtimeRoutineFlag: true,
      createAt: DateTime.parse("2025-06-03"),
      updateAt: DateTime.parse("2025-06-03"),
      deleteAt: DateTime.parse("2025-06-03"),
    ),
    RoutineModel(
      routineId: 'b1-1',
      userId: 'b1',
      routineTitle: '基本情報の勉強',
      routineStart: DateTime.parse("2025-06-03T16:00:00"),
      routineEnd: DateTime.parse("2025-06-03T18:00:00"),
      routineTime: 1,
      routineBody: 'data',
      realtimeRoutineFlag: true,
      createAt: DateTime.parse("2025-06-03"),
      updateAt: DateTime.parse("2025-06-03"),
      deleteAt: DateTime.parse("2025-06-03"),
    ),
    RoutineModel(
      routineId: 'c1-1',
      userId: 'c1',
      routineTitle: 'にんじん生活',
      routineStart: DateTime.parse("2025-06-03T16:00:00"),
      routineEnd: DateTime.parse("2025-06-03T18:00:00"),
      routineTime: 1,
      routineBody: 'data',
      realtimeRoutineFlag: true,
      createAt: DateTime.parse("2025-06-03"),
      updateAt: DateTime.parse("2025-06-03"),
      deleteAt: DateTime.parse("2025-06-03"),
    ),
  ];

  List<RoutineModel> get routineModel => _post;
}
