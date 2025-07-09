//[test]ユーザー情報

import '../model/user/user_Info.dart';

class UserTest {
  final posts = UserInfoModel(
    mochiId: 'miumiu',
    userName: 'みゆっち',
    userImgPath: 'assets/icon/icon2.png',
  );
  UserInfoModel get post => posts;
}

class UserTests {
  final List<UserInfoModel> testUsers = [
    UserInfoModel(
      mochiId: 'user01',
      userName: 'Alice',
      userImgPath: 'assets/icon/icon1.png',
    ),
    UserInfoModel(
      mochiId: 'user02',
      userName: 'Bob',
      userImgPath: 'assets/icon/icon3.png',
    ),
    UserInfoModel(
      mochiId: 'user03',
      userName: 'Charlie',
      userImgPath: 'assets/icon/icon4.png',
    ),
    UserInfoModel(
      mochiId: 'user04',
      userName: 'Dana',
      userImgPath: 'assets/icon/icon5.png',
    ),
    UserInfoModel(
      mochiId: 'user05',
      userName: 'Eric',
      userImgPath: 'assets/icon/icon6.png',
    ),
    UserInfoModel(
      mochiId: 'user06',
      userName: 'Fiona',
      userImgPath: 'assets/icon/icon7.png',
    ),
    UserInfoModel(
      mochiId: 'user07',
      userName: 'George',
      userImgPath: 'assets/icon/icon8.png',
    ),
    UserInfoModel(
      mochiId: 'user08',
      userName: 'Hana',
      userImgPath: 'assets/icon/icon9.png',
    ),
    UserInfoModel(
      mochiId: 'user09',
      userName: 'Ian',
      userImgPath: 'assets/icon/icon1.png',
    ),
    UserInfoModel(
      mochiId: 'user10',
      userName: 'Jill',
      userImgPath: 'assets/icon/icon3.png',
    ),
  ];
  List<UserInfoModel> get post => testUsers;
}
