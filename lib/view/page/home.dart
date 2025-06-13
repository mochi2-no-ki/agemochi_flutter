import 'package:agemoti/testData/user_controller.dart';
import 'package:agemoti/view/components/userInfo.dart';
import 'package:flutter/material.dart';

import 'package:agemoti/testData/routine_controller.dart';
import '../components/card.dart'; // RoutineCard のパスに注意
import '../../model/routine/routine_model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final RoutineController _routineController = RoutineController();
  final MyprofileController _myProfileController = MyprofileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _card(),
            )
          ],
        ),
      ),
    );
  }

  Widget _card() {
    final List<RoutineModel> posts = _routineController.routineModel;

    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            RoutineCard(index: index, post: posts[index]),
          ],
        );
      },
    );
  }
}
