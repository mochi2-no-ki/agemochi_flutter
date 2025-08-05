import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const/api_url.dart';

// API URL
String routineCreateUrl = ApiUrl.routinePost();

Future<String> postRoutine({
  required String userId,
  required String title,
  required String startTime,
  required String endTime,
  required int timeMinutes,
  required String body,
  required bool realtimeFlag,
  required List<String> tagIds,
}) async {
  final url = Uri.parse(routineCreateUrl);

  final Map<String, dynamic> requestBody = {
    "user_id": userId,
    "routine_title": title,
    "routine_start": startTime,
    "routine_end": endTime,
    "routine_time": timeMinutes,
    "routine_body": body,
    "realtime_routine_flag": realtimeFlag,
    "tags": tagIds.map((id) => {"tag_id": id}).toList(),
  };

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return responseData['data']['routine_id']; // ← uuidが返る
  } else {
    throw Exception('ルーティーン投稿に失敗しました: ${response.statusCode}');
  }
}
