//【API】ユーザー情報を簡易取得する
import 'dart:convert';
import 'package:http/http.dart' as http;

//url
import '../../const/api_url.dart';

//model
import '../../model/user/user_Info.dart';

/// 取得する情報--
/// *設定しているユーザーicon
/// *mochi_id
/// *名前
/// --
/// メソッド : GET
/// パスパラメータ : mochi_id(user_accountテーブルのmochi_idを指定)
/// クエリパラメータ : なし
/// リクエストボディ : なし

Future<UserInfoModel> fetchUserInfo(String mochiId) async {
  final url = Uri.parse(ApiUrl.userInfo(mochiId));
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print('[API]ユーザの情報を簡易取得');

    final data = json.decode(response.body)['data'];
    return UserInfoModel.fromJson(data);
  } else {
    throw Exception('ユーザー情報の取得に失敗しました');
  }
}
