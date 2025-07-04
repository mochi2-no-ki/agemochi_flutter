import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/user/user_Info.dart';

Future<UserInfoModel> fetchUserInfo(String mochiId) async {
  final url = Uri.parse(
      'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/user/miumiu');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return UserInfoModel.fromJson(data);
  } else {
    throw Exception('ユーザー情報の取得に失敗しました');
  }
}
