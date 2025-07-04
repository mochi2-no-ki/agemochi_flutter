import '../../model/routine/routine_card.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

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
  const baseUrl =
      'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/routine/list';
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

  final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    print("ルーティーンカード 200");
    final jsonData = jsonDecode(response.body);
    return RoutineListResponse.fromJson(jsonData);
  } else {
    print("ルーティーンカード error");
    throw Exception('ルーティーンカードの取得に失敗しました ${response.statusCode}');
  }
}
