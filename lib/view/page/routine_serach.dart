//ルーティーン検索画面

//↓↓↓↓↓↓↓実装できていないもの↓↓↓↓↓↓
//・入力内容による絞込検索
//・タグ指定による絞込検索

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoutineSearch extends StatefulWidget {
  RoutineSearch({super.key});

  @override
  State<RoutineSearch> createState() => _RoutineSearchState();
}

class _RoutineSearchState extends State<RoutineSearch> {
  final TextEditingController _searchController = TextEditingController();
  String _userName = '';
  String _mochiId = 'miumiu'; // 仮ユーザーID（後で置き換え）
  List<String> _tagList = [];

  bool isFilterVisible = false;
  bool isRR = false;
  String? selectedTime;
  String? selectedStartTime;
  String? selectedEndTime;

  List<dynamic> _routines = [];
  int _offset = 0;
  final int _limit = 8;
  bool _isLoading = false;
  bool _hasMore = true;
  String _keyword = '';
  final ScrollController _scrollController = ScrollController();

  // モックのおすすめタグ（固定8つ）
  final List<String> _recommendedTags = [
    '筋トレ',
    '朝活',
    'モーニング',
    '勉強',
    'チルタイム',
    '自分時間',
    '読書',
    '運動'
  ];

  @override
  void initState() {
    super.initState();
    _fetchUser();

    _fetchRoutines();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !_isLoading &&
          _hasMore) {
        _fetchRoutines();
      }
    });
  }

  //タグ検索メソッド（現在はTextfieldになにか入力されるとnotionの　タグ検索　のモックurlを取得する　機能のみ）
  void _onTagSearch() async {
    //Textfieldの入力内容
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) {
      setState(() {
        _tagList = [];
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/tag/list?search=$keyword'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tags = data['data']['tags'] as List;
        setState(() {
          _tagList = tags.map((tag) => tag['tag_name'].toString()).toList();
        });
      } else {
        setState(() => _tagList = []);
      }
    } catch (e) {
      print('タグ取得失敗: $e');
      setState(() => _tagList = []);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //ユーザー情報取得API
  Future<void> _fetchUser() async {
    final response = await http.get(Uri.parse(
        'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/user/$_mochiId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      setState(() {
        _userName = data['user_name'];
      });
    }
  }

  //ルーティーン取得API
  Future<void> _fetchRoutines() async {
    setState(() => _isLoading = true);
    final response = await http.get(Uri.parse(
        'https://0932bf29-602b-4402-ad4b-1ad193e06e9c.mock.pstmn.io/routine/list'));

    if (response.statusCode == 200) {
      final List<dynamic> allRoutines =
          json.decode(response.body)['data']['routines'];

      final filtered = allRoutines.where((routine) {
        final title = routine['routine_title'] ?? '';
        final tags = routine['tags']
            .map<String>((tag) => tag['tag_name'] as String)
            .toList();
        return title.contains(_keyword) ||
            tags.any((tag) => tag.contains(_keyword));
      }).toList();

      final sliced = filtered.skip(_offset).take(_limit).toList();

      setState(() {
        _offset += sliced.length;
        _hasMore = sliced.length == _limit;
        _routines.addAll(sliced);
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  //キーワード検索メソッド（ルーティーンタイトル、タグ検索）
  void _onSearchChanged() {
    setState(() {
      _routines.clear();
      _offset = 0;
      _hasMore = true;
      _keyword = _searchController.text.trim();
    });
    _fetchRoutines();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    //タグ検索欄になにか入力されているなら true 空欄なら false
    final isSearching = _searchController.text.trim().isNotEmpty;

    //表示するタグの内容
    final tagsToShow = isSearching ? _tagList : _recommendedTags;

    //表示するテキスト
    final headerText = isSearching ? '検索結果' : 'おすすめタグ';

    //所要時間選択肢
    List<String> timeDurations = [
      '00:30',
      '00:45',
      '01:00',
      '01:15',
      '01:30',
      '01:45',
      '02:00'
    ];

    //時間帯選択肢
    List<String> timeSlots = List.generate(
      96,
      (index) =>
          '${(index ~/ 4).toString().padLeft(2, '0')}:${(index % 4 * 15).toString().padLeft(2, '0')}',
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 248, 245, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 戻るボタン + ユーザー情報
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: width * 0.8,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      //------自分のユーザーアイコン表示
                      //------仮でアセットのアイコン表示--------
                      CircleAvatar(
                          radius: 24,
                          child: Image.asset('assets/icon/icon2.png')),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_userName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(_mochiId,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey))
                        ],
                      )
                    ],
                  ),
                )),

            SizedBox(height: height * 0.02),

            // 入力欄 + 絞り込みボタン
            Center(
              child: Container(
                width: width * 0.8,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (value) {
                            _onTagSearch();
                            _onSearchChanged();
                          },
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: '入力してください',
                            suffixIcon: const Icon(Icons.search,
                                color: Colors.deepOrange),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFilterVisible = !isFilterVisible;
                            });
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const Text('絞り込む', style: TextStyle(fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.01),

            // タグ表示　今はなにか入力されるとタグ検索のモックurlを表示
            Center(
              child: Text(
                headerText,
                style: const TextStyle(color: Colors.deepOrange, fontSize: 16),
              ),
            ),
            SizedBox(height: height * 0.01),
            Center(
                child: Container(
              width: width * 0.8,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tagsToShow.length > 8 ? 8 : tagsToShow.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 横2列
                  mainAxisSpacing: 12, // 縦スペース
                  crossAxisSpacing: 24, // 横スペース
                  childAspectRatio: 6, // ボタンの横長比率（調整可）
                ),
                itemBuilder: (context, index) {
                  final tag = tagsToShow[index];
                  return OutlinedButton.icon(
                    onPressed: () {}, // ← ボタンタップ時の処理（後で）
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Colors.orange),
                    ),
                    icon: const Icon(Icons.tag,
                        color: Colors.deepOrange, size: 16),
                    label:
                        Text(tag, style: const TextStyle(color: Colors.black)),
                  );
                },
              ),
            )),

            // 絞込検索部分
            if (isFilterVisible)
              Center(
                  child: Container(
                width: width * 0.8,
                child: Column(
                  children: [
                    //リアルタイムルーティーンを含むかどうか
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.0),
                          ),
                          const Center(
                            child: Text('RR'),
                          ),
                        ],
                      ),
                      Switch(
                        value: isRR,
                        onChanged: (value) {
                          setState(() {
                            isRR = value;
                          });
                        },
                        activeColor: Colors.deepOrange,
                        inactiveThumbColor: Colors.deepOrange,
                      ),
                    ]),
                    //所要時間
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      const Text('所要時間'),
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.deepOrange,
                      ),
                      DropdownButton<String>(
                        value: selectedTime,
                        hint: const Text('選択してください'),
                        onChanged: (value) {
                          setState(() {
                            selectedTime = value;
                          });
                        },
                        items: timeDurations
                            .map((t) =>
                                DropdownMenuItem(value: t, child: Text(t)))
                            .toList(),
                      ),
                    ]),
                    //時間帯
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      const Text('時間帯　'),
                      const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.deepOrange,
                      ),
                      Row(
                        children: [
                          const Text('開始: '),
                          DropdownButton<String>(
                            value: selectedStartTime,
                            hint: const Text('選択'),
                            onChanged: (value) {
                              setState(() {
                                selectedStartTime = value;
                              });
                            },
                            items: timeSlots
                                .map((t) =>
                                    DropdownMenuItem(value: t, child: Text(t)))
                                .toList(),
                          ),
                          SizedBox(width: width * 0.02),
                          const Text('終了: '),
                          DropdownButton<String>(
                            value: selectedEndTime,
                            hint: const Text('選択'),
                            onChanged: (value) {
                              setState(() {
                                selectedEndTime = value;
                              });
                            },
                            items: timeSlots
                                .map((t) =>
                                    DropdownMenuItem(value: t, child: Text(t)))
                                .toList(),
                          ),
                        ],
                      ),
                    ])
                  ],
                ),
              )),

            SizedBox(height: height * 0.02),

            //ルーティーン表示
            Expanded(
              child: Center(
                child: Container(
                  width: width * 0.8,
                  // height: height * 0.8,
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _routines.length + (_hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _routines.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final routine = _routines[index];
                      final user = routine['user'];
                      final tags = routine['tags'] as List<dynamic>;
                      final time = (routine['routine_time'] as int);
                      final duration =
                          '${(time ~/ 60).toString().padLeft(2, '0')}:${(time % 60).toString().padLeft(2, '0')}';

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  child: Image.asset(
                                      'assets/icon/icon1.png'), //ユーザーアイコンをすべて仮でicon1.pngで表示
                                  backgroundColor: Colors.grey[200],
                                ),
                                SizedBox(width: width * 0.01),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("name",
                                        style: TextStyle(fontSize: 10)),
                                    Text(user['mochi_id'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              routine['routine_title'],
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            SizedBox(height: height * 0.01),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: tags
                                  .map((tag) => Text(
                                        '# ${tag['tag_name']}',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.deepOrange),
                                      ))
                                  .toList(),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.timer_outlined, size: 16),
                                    Text(duration,
                                        style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                        Icons
                                            .back_hand_sharp, //参考になったの良いアイコンが見つかってないです
                                        size: 16,
                                        color: Colors.orange),
                                    Text('${routine['reference_count']}',
                                        style: const TextStyle(fontSize: 12)),
                                    SizedBox(width: width * 0.01),
                                    const Icon(Icons.bookmark_border, size: 16),
                                    Text('${routine['routine_save_count']}',
                                        style: const TextStyle(fontSize: 12)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
