class UserInfoModel {
  final String mochiId;
  final String userName;
  final String userImgPath;

  UserInfoModel({
    required this.mochiId,
    required this.userName,
    required this.userImgPath,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      mochiId: json['mochi_id'] as String,
      userName: json['user_name'] as String,
      userImgPath: json['user_img_path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mochi_id': mochiId,
      'user_name': userName,
      'user_img_path': userImgPath,
    };
  }
}
