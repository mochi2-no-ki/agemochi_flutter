import 'package:flutter/material.dart';

class UserAccountModel {
  final String userId; //ユーザーID
  final String mochiId; //ユーザー指定のID
  final String userName; //名前
  final String userImgPath; //ユーザーの画像のパス
  final Text? introduction; //自己紹介メッセージ
  final String? currentUserBannerId; //現在のバナーID
  final String? currentIconFrameId; //現在ののアイコンフレーム
  final DateTime createdAt; //作成日時
  final DateTime? updatedAt; //更新日時

  UserAccountModel({
    required this.userId,
    required this.mochiId,
    required this.userName,
    required this.userImgPath,
    required this.introduction,
    required this.currentUserBannerId,
    required this.currentIconFrameId,
    required this.createdAt,
    required this.updatedAt,
  });
}

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
