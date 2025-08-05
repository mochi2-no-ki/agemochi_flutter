import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../const/color.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Timer? _debounce;
  bool _isUsernameAvailable = false;
  bool _isCheckingUsername = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onUsernameChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  //2秒待機後にuser_name確認APIへ
  void _onUsernameChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), _checkUsernameAvailability);
  }

  //user_name確認API
  Future<void> _checkUsernameAvailability() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      setState(() => _isUsernameAvailable = false);
      return;
    }

    setState(() => _isCheckingUsername = true);

    try {
      final response = await http.get(
        Uri.parse(
          'https://your-api.com/user/check?username=$username', //新規登録API実装後にURL変更
        ),
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          // _isUsernameAvailable = result['???'];  APIレスポンスを true false で実装し、user_name使用可能か判断？？？
          _isCheckingUsername = false;
        });
      }
    } catch (e) {
      print('エラー: $e');
      setState(() => _isCheckingUsername = false);
      setState(() => _isUsernameAvailable =true); //現在はAPI未実装のためエラーが出たときにuser_name使用可能としている
    }
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    //user_nameが使用可能なときアイコンを表示
    final checkIcon = _isUsernameAvailable
        ? Icon(Icons.check_circle, color: ColorConst.bt)
        : null;

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
        ),
      ),

      body: SafeArea(
        child: Column(children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(
              children: [
                const Text('新規登録',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: height * 0.01),
                _buildTextField('名前', _nameController),
                SizedBox(height: height * 0.01),
                _buildTextField('メールアドレス', _emailController),
                SizedBox(height: height * 0.01),
                _buildTextField('user name',_usernameController,
                  suffix:
                      _isCheckingUsername //_isCheckingUsernameが true の間ロードアニメーション表示
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              ),
                            )
                          : checkIcon,
                ),
                SizedBox(height: height * 0.01),
                _buildTextField('パスワード', _passwordController, obscure: true),
                SizedBox(height: 32),
                
                ElevatedButton(
                  onPressed: () {
                    // 作成処理をここに記述
                    print("作成処理実行");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.bk,
                    foregroundColor: ColorConst.bt,
                    shadowColor: ColorConst.bk,
                    elevation: 5,
                    side: const BorderSide(color: ColorConst.bt),
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.02, horizontal: width * 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('作成',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ),

              ],
            ),
          ),
        ]),
      ),
    );
  }
}
