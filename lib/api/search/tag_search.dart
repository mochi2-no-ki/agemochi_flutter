//【API】tagの検索
import 'dart:convert';
import 'package:http/http.dart' as http;

//url
import '../../const/api_url.dart';

//model
import '../../model/routine/routine_tag.dart';

/// 取得する情報--
/// --
/// メソッド : GET
/// パスパラメータ : なし
/// クエリパラメータ : search(検索用クエリ 検索したいタグの文字が入る 例:筋トレ、資格etc...)
/// リクエストボディ : なし

Future<List<TagModel>> fetchTagSearch(String query) async {
  final uri = Uri.parse(ApiUrl.tagSearch(query));

  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('タグの取得に失敗しました');
  }

  final json = jsonDecode(response.body);
  final tagResponse = TagResponse.fromJson(json);
  print('【API】タグ検索 (検索 : $query)');

  return tagResponse.data.tags;
}
