///RRに参加している人を取得
import 'package:http/http.dart' as http;
import 'dart:convert';

//url
import '../../const/api_url.dart';

///mode :
import '../../model/user/user_Info.dart';

/// 取得する情報--
/// - greeting、announceの全体チャットは全取得
/// - questionはメッセージの送信者の”mochi_id” = user={mochi_id}を取得
/// - replyはメッセージの"reply_mochi_id" = user={mochi_id}を取得
/// --
/// メソッド : GET
/// パスパラメータ : routine_id(routineテーブルのroutine_id)
/// クエリパラメータ : なし
/// リクエストボディ : なし
///

Future<List<UserInfoModel>> fetchParticipantList(String rrRoutineId) async {
  final url = Uri.parse(ApiUrl.participantId(rrRoutineId));

  final response = await http.get(url);

  if (response.statusCode == 200) {
    print('[API] RR参加者全員取得成功');
    final List<dynamic> jsonList = json.decode(response.body);
    print('参加者一覧 : ${response.body}');
    return jsonList
        .map((jsonItem) => UserInfoModel.fromJson(jsonItem))
        .toList();
  } else {
    print('[API] ステータスコード: ${response.statusCode}');
    throw Exception('RR参加者全員取得に失敗しました');
  }
}
