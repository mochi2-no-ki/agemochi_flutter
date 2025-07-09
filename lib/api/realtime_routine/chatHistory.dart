///【API】チャットの全履歴を取得する
import 'package:http/http.dart' as http;
import 'dart:convert';

//url
import '../../const/api_url.dart';

//mode :
import '../../model/message/message.dart';

/// 取得する情報--
/// - greeting、announceの全体チャットは全取得
/// - questionはメッセージの送信者の”mochi_id” = user={mochi_id}を取得
/// - replyはメッセージの"reply_mochi_id" = user={mochi_id}を取得
/// --
/// メソッド : GET
/// パスパラメータ : routine_id(routineテーブルのroutine_id)
/// クエリパラメータ : offset(位置情報取得数は15こずつ), mochiId
/// リクエストボディ : なし
Future<List<Message>> fetchChatHistory(String routineId,
    {int offset = 0, required String mochiId}) async {
  try {
    final url = Uri.parse(ApiUrl.chatHistory(routineId, offset, mochiId));

    print('Fetching chat history: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];

      return data.map((e) => Message.fromJson(e)).toList();
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('チャット履歴取得エラー: $e');
    throw Exception('チャット履歴の取得に失敗しました');
  }
}
