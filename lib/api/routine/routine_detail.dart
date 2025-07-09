///【API】ルーティーンの詳細情報を取得する
import 'package:http/http.dart' as http;
import 'dart:convert';

///url
import '../../const/api_url.dart';

///model : なし
/// 取得する情報--
/// --
/// メソッド : GET
/// パスパラメータ : routine_id(routineテーブルのroutine_id)
/// クエリパラメータ : なし
/// リクエストボディ : なし

Future<Map<String, dynamic>> fetchRoutineDetail(String routineId) async {
  print('詳細表示のためのroutineId($routineId)をgetしました');
  try {
    final Uri url = Uri.parse(ApiUrl.routineDetail(routineId));
    print('(URL表示 : ($url)');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("【API】ルーティーン詳細 200");
      final jsonData = jsonDecode(response.body);
      print(response.body[1]);
      return jsonData['data'];
    } else {
      throw Exception('HTTPエラー: ${response.statusCode}');
    }
  } catch (error) {
    print('ルーティーン詳細 error');
    throw Exception('ルーティーン詳細の取得に失敗しました');
  }
}
