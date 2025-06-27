import 'package:flutter/material.dart';

import 'package:agemoti/testData/routine_test.dart';
import '../components/card.dart';
import '../../model/routine/routine_model.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CardController _routineController = CardController();

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
    final List<RoutineCardModel> posts = _routineController.post;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final routine = posts[index];
        print(userTestData.length);

        return RoutineCard(
          index: index,
          post: routine,
        );
      },
    );
  }
}
