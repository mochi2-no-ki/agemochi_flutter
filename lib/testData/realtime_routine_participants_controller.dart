//[test]リアルタイムルーティン参加ユーザー情報

import '../model/realtime_routine/realtime_routine_participant.dart';

class RealtimeRoutineParticipantsController {
  final List<RealtimeRoutineParticipant> _rrpart = [
    RealtimeRoutineParticipant(
      realtimeRoutimeParticipantId: 'p1',
      realtimeRoutineId: 'b1-rr-1',
      userId: 'a1',
      createdAt: DateTime.parse("2025-06-03"),
    ),
    // RealtimeRoutineParticipant(
    //   realtimeRoutimeParticipantId: 'p2',
    //   realtimeRoutineId: 'b1-rr-1',
    //   userId: 'c1',
    //   createdAt: DateTime.parse("2025-06-03"),
    // ),
    RealtimeRoutineParticipant(
      realtimeRoutimeParticipantId: 'p3',
      realtimeRoutineId: 'b1-rr-1',
      userId: 'd1',
      createdAt: DateTime.parse("2025-06-03"),
    ),
  ];

  List<RealtimeRoutineParticipant> get rr_participants => _rrpart;
}
