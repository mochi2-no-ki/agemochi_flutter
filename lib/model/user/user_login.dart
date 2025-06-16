//user_login

class UserLoginModel {
  final String userId; //ユーザーID
  final String mail; //メールアドレス
  final String password; //パスワード
  final DateTime createdAt; //作成日時
  final DateTime updatedAt; //更新日時

  UserLoginModel({
    required this.userId,
    required this.mail,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });
}
