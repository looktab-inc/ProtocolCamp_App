import 'package:flutter/material.dart';
import '../widget/appbar.dart';

class CandyHistory extends StatelessWidget {
  const CandyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
            title: 'Candy history',
            backgroundColor: Colors.blue,
            titleColor: Colors.white,
            onButtonPressed: () {
              print('뒤로가기 버튼이 클릭되었습니다.');
            },
          ),
        body: Center(
        ),
      ),
    );
  }
}

void main() {
  runApp(const CandyHistory());
}
