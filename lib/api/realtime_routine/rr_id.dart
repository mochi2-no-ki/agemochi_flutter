//【API】開催されているリアルタイムルーティーンのIDを取得
import 'dart:convert';
import 'package:http/http.dart' as http;
//url
import '../../const/api_url.dart';

///model
// import '../../model/realtime_routine/realtime_routine.dart';

/// 取得する情報
/// *リアルタイムルーティーンのID
/// メソッド : GET
/// パスパラメータ : routine_id(routineテーブルのroutine_id)
/// クエリパラメータ : なし
/// リクエストボディ : なし
Future<Map<String, dynamic>> fetchRRid(String routineId) async {
  final url = Uri.parse(ApiUrl.routineRealtime(routineId));
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    print('rrのID : $data');
    return data;
  } else {
    throw Exception('リアルタイムルーティーンの取得に失敗しました');
  }
}
