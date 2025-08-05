import 'dart:async';
import 'dart:convert';
import '../../const/color.dart';
import 'package:agemoti/view/page/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //ログイン試行API
  Future<void> _checkUsernameAvailability() async {
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

    return Scaffold(

      body: SafeArea(
        child: Column(children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(
              children: [
                SizedBox(height: height * 0.1),
                const Text('ログイン',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: height * 0.01),
                _buildTextField('メールアドレス', _emailController),

                SizedBox(height: height * 0.01),
                _buildTextField('パスワード', _passwordController, obscure: true),

                SizedBox(height: height * 0.25),
                ElevatedButton(
                  onPressed: () {
                  // ログイン処理をここに記述
                  print("ログイン処理実行");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.bt,
                    foregroundColor: ColorConst.bk,
                    shadowColor: Colors.black,
                    elevation: 5,
                    side: const BorderSide(color: ColorConst.bt),
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.02, horizontal: width * 0.18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:const Text('ログイン',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                  ),
                ),

                SizedBox(height: height * 0.1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.bk,
                    foregroundColor: ColorConst.bt,
                    shadowColor: ColorConst.bk,
                    elevation: 5,
                    side: const BorderSide(color: ColorConst.bt),
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.02, horizontal: width * 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:const Text('アカウント新規作成',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    )
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
