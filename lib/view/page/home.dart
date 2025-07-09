import 'package:flutter/material.dart';

///const
import '../../const/color.dart';

///component
import 'package:agemoti/view/components/userInfo.dart';
import '../components/card.dart';

///page
import '../../api/routine/routine_card.dart';

///model
import '../../model/user/user_Info.dart';
import '../../model/routine/routine_card.dart';

///api
import './routin_post.dart';

class Home extends StatefulWidget {
  final UserInfoModel post;
  Home({
    super.key,
    required this.post,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: UserInfo(post: widget.post)),
                Expanded(
                  flex: 0,
                  child: SizedBox(
                    height: height * 0.05,
                    width: width * 0.2,
                    //TODO:higaht/width調整する
                    child: IconButton(
                        onPressed: () {
                          //TODO:検索画面に遷移する処理書く
                        },
                        icon: Icon(
                          Icons.search,
                          color: ColorConst.bt,
                        )),
                  ),
                )
              ],
            ),
            Expanded(
              child: _card(),
            )
          ],
        ),
      ),
      floatingActionButton: _createButton(),
    );
  }

  Widget _card() {
    return FutureBuilder<RoutineListResponse>(
      future: fetchRoutineList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('エラーが発生しました'));
        } else if (!snapshot.hasData || snapshot.data!.routines.isEmpty) {
          return const Center(child: Text('ルーティーンがありません'));
        } else {
          final posts = snapshot.data!.routines;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            padding: const EdgeInsets.all(8.0),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return RoutineCard(
                index: index,
                post: posts[index],
              );
            },
          );
        }
      },
    );
  }

  Widget _createButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoutinePost(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(30),
        backgroundColor: ColorConst.bt,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      child: const Icon(Icons.add, size: 30),
    );
  }
}
