import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../const/color.dart';
import 'package:http/http.dart' as http;

class Followed extends StatefulWidget {
  @override
  _FollowedState createState() => _FollowedState();
}

class _FollowedState extends State<Followed> {

  @override
  void initState() {
    super.initState();

    _loadMoreUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 && !_isLoading) {
        _loadMoreUsers();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadMoreUsers() {
    setState(() => _isLoading = true);

    // 遅延ロードの模擬（ネットワーク想定）
    Future.delayed(const Duration(milliseconds: 500), () {
      final nextUsers = mockUsers.skip(_offset).take(_limit).toList();
      setState(() {
        displayedUsers.addAll(nextUsers);
        _offset += _limit;
        _isLoading = false;
      });
    });
  }

  void _onUserTap(Map<String, String> user) {
    print('タップされたタイル: ${user['user_name']}');
    // 遷移などをここに記述
  }

  //各入力項目のウィジェット
  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscure = false, Widget? suffix}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  final ScrollController _scrollController = ScrollController();
  final int _limit = 11;
  int _offset = 0;
  bool _isLoading = false;

  List<Map<String, String>> displayedUsers = [];

  List<Map<String, String>> mockUsers = List.generate(50, (index) {
    return {
      'usr_img': 'https://via.placeholder.com/100x100.png?text=User+$index',
      'user_name': 'user_$index',
      'user_id': 'id_$index',
      'profile': 'user_$index のプロフィール',
    };
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08), // 高さを指定

        child: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorConst.bt,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: ColorConst.bk,
          bottomOpacity: 0.0,
          elevation: 0.0,
          
        ),
      ),

      body: SafeArea(
        child: Column(children: [
          Center(
            child: Text(
              mockUsers.length.toString() +  "フォロー中",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: ListView.builder(
              controller: _scrollController,
              itemCount: displayedUsers.length + 1, // 最後にローディング表示
              itemBuilder: (context, index) {
                if (index >= displayedUsers.length) {
                  return _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox();
                }

                final user = displayedUsers[index];
                return GestureDetector(
                  onTap: () => _onUserTap(user),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.01),
                                      
                    //とりあえずリストで仮表示
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user['usr_img']!),
                        backgroundColor: Colors.black,
                        radius: 18.0,
                        child: CircleAvatar(
                          radius: 17.0,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      title: Text(user['user_name']!),
                      subtitle: Expanded(child: Text('${user['user_id']}  ',)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user['profile'] ?? '',
                            style: TextStyle(fontSize: 11),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                      tileColor: ColorConst.bk,
                    )
                  ),
                );
              },
            ),
          ),
        ],)
      ),
    );
  }

}