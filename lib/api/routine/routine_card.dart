//【API】ルーティーン一覧を取得する
import 'package:http/http.dart' as http;
import 'dart:convert';

//url
import '../../const/api_url.dart';

//model
import '../../model/routine/routine_card.dart';

/// 取得する情報--
/// *sort
/// *表現提案
/// *search
/// *rr(リアルタイムルーティーンかどうかのフラグ)
/// *time(ルーティーンの所要時間)
/// *start(ルーティーンが始まる時間)
/// *end(ルーティーンが終わる時間)
/// *user(指定されたmochi_id)
/// --
/// メソッド : GET
/// パスパラメータ : routine_id(routineテーブルのroutine_id)
/// クエリパラメータ : offset sort search rr time start end user
/// リクエストボディ : なし

Future<RoutineListResponse> fetchRoutineList({
  int offset = 0,
  String sort = 'random',
  String? search,
  bool? rr,
  int? time,
  String? start,
  String? end,
  String? user,
}) async {
  final url = ApiUrl.routineList();

  final queryParameters = <String, String>{
    'offset': offset.toString(),
    'sort': sort,
  };

  if (search != null) queryParameters['search'] = search;
  if (rr != null) queryParameters['rr'] = rr.toString();
  if (time != null) queryParameters['time'] = time.toString();
  if (start != null) queryParameters['start'] = start;
  if (end != null) queryParameters['end'] = end;
  if (user != null) queryParameters['user'] = user;

  final uri = Uri.parse(url).replace(queryParameters: queryParameters);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    print("【API】ルーティーンカード 200");
    final jsonData = jsonDecode(response.body);
    return RoutineListResponse.fromJson(jsonData);
  } else {
    print("ルーティーンカード error");
    throw Exception('ルーティーンカードの取得に失敗しました ${response.statusCode}');
  }
}
