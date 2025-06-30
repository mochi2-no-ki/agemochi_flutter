import 'package:flutter/material.dart';
import './routin_post.dart';
import 'package:agemoti/testData/routine_test.dart';
import '../components/card.dart';
import '../../model/routine/routine_model.dart';
import '../../const/color.dart';
import '../../testData/user_test.dart';
import '../../model/user/user_account.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CardController _routineController = CardController();
  final myAccount = UserTest().myController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    child: _createButton(myAccount),
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
    final List<RoutineCardModel> posts = _routineController.post;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final routine = posts[index];

        return RoutineCard(
          index: index,
          post: routine,
        );
      },
    );
  }

  Widget _createButton(UserAccountModel myAccount) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoutinePost(myAccount: myAccount),
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
