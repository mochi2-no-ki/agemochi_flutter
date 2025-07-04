import 'package:flutter/material.dart';
import './routin_post.dart';
import '../components/card.dart';
import '../../const/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/routine/routine_card.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<RoutineCardModel>> fetchRoutineList() async {
    final url = Uri.parse(
        'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/routine/list');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final routineList = RoutineListResponse.fromJson(jsonData);
      return routineList.routines;
    } else {
      throw Exception('ルーティーン一覧の取得に失敗しました');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _card(),
                  Positioned(
                    top: height * 0.85,
                    left: width * 0.7,
                    child: _createButton(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _card() {
    return FutureBuilder<List<RoutineCardModel>>(
      future: fetchRoutineList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('エラーが発生しました'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('ルーティーンがありません'));
        } else {
          final posts = snapshot.data!;
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
