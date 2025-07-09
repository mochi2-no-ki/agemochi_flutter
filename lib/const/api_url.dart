import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  static String get base => dotenv.env['API_BASE_URL'] ?? '';

  ///検索・homeでの一覧表示
  ///【/routine/list?offset={取得位置}&sort={ソート条件}&search={検索条件}&rr={true|false}&time={所要時間}&start={開始時間}&end={終了時間}&user={mochi_id}】
  static String routineList() => '$base/routine/list';

  ///ユーザの情報を簡易取得【/user/{mochi_id}】
  static String userInfo(String id) => '$base/user/miumiu';

  ///ルーティーンの詳細【/routine/{routine_id}/detail】
  static String routineDetail(String id) => '$base/routine/$id/detail';

  ///タグリストの取得【/tag/list?search={検索条件}】
  static String tagSearch(String search) => '$base/tag/list?search=$search';

  ///ルーティーンの作成【/routine/create/】
  static String routinePost() => '$base/routine/create';

  ///挙手ボタン【/rr/{realtime_routine_id}/raise_hand】
  static String raiseHand(String id) => '$base/rr/$id/raise_hand';

  ///挙手の許可【/rr/{realtime_routine_id}/apply】
  static String raiseHandApply(String id) => '$base/rr/$id/apply';

  ///よろしく・ありがとうタイム【/rr/{realtime_routine_id}/chat/greeting】
  static String greetingTime(String id) => '$base/rr/$id/chat/greeting';

  ///アナウンス【/rr/{realtime_routine_id}/chat/announce】
  static String announce(String id) => '$base/rr/$id/chat/announce';

  ///質問【/rr/{realtime_routine_id}/chat/question】
  static String question(String id) => '$base/rr/$id/chat/question';

  ///返信【/rr/{realtime_routine_id}/chat/reply】
  static String reply(String id) => '$base/rr/$id/chat/reply';

  ///チャットの全履歴取得【rr/{realtime_routine_id}/chat/history?offset={取得位置}&user={mochi_id}】
  static String chatHistory(String routineId, int offset, [String? mochiId]) {
    final basePath = '$base/rr/$routineId/chat/history';
    final offsetParam = 'offset=$offset';
    final mochiParam = mochiId != null ? '&user=$mochiId' : '';
    return '$basePath?$offsetParam$mochiParam';
  }

  ///リアルタイムルーティーンの開催【routine/{routine_id}/hold_event】
  static String holdEvent(String routineId) =>
      '$base//routine/$routineId/hold_event';

  ///開催されているリアルタイムルーティーンのID取得【routine/{routine_id}/rr_holding】
  static String routineRealtime(String routineId) =>
      '$base/routine/$routineId/rr_holding';

  ///リアルタイムルーティーン参加【/rr/{realtime_routine_id}/partcipate】
  static String partcipates(String rrId) => '$base/rr/$rrId/partcipate';

  ///RRの参加者全員取得【/rr/{realtime_routine_id}/participant/list/listen】
  static String participantId(String rrId) =>
      '$base/rr/$rrId/participant/list/listen';

  ///質問 ON/OFF【/rr/{realtime_routine_id}/question_possible】
  static String raiseHandOnOff(String rrId) =>
      '$base/rr/$rrId/question_possible';

  ///参加中のRRで質問がON/OFFどちらなのか見る【/rr/{realtime_routine_id}/question_possible_state/listen】
  static String raiseHandOnOffcheck(String rrId) =>
      '$base/rr/$rrId/question_possible_state/listen';

  ///ユーザーがリアルタイムルーティーンに入室した際、既に入室済みの参加者の情報を取得
  ///自分より後に入室してきた参加者を取得する
}
