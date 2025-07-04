import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchRoutineDetail(String routineId) async {
  try {
    final Uri url = Uri.parse(
      'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/routine/01979b96-757b-7c70-b405-4d46c91a4f04/detail',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("ルーティーン詳細 200");
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('HTTPエラー: ${response.statusCode}');
    }
  } catch (error) {
    print('ルーティーン詳細 error');
    throw Exception('ルーティーン詳細の取得に失敗しました');
  }
}
