import 'package:flutter/material.dart';

import '../widget/appbar.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
          title: 'MyPage',
          backgroundColor: Colors.blue,
          titleColor: Colors.white,
          onButtonPressed: () {
            print('뒤로가기 버튼이 클릭되었습니다.');
          },
        ),
        body: Center(),
      ),
    );
  }
}

void main() {
  runApp(const MyPage());
}
