import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinji/src/key.dart';
import 'package:tinji/src/widget/appbar.dart';

import '../data.dart';
import '../swipe/swipe.dart';

class Join extends StatelessWidget {
  const Join({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinji',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JoinScreen(),
    );
  }
}

class JoinScreen extends StatefulWidget {
  @override
  _JoinState get createState => _JoinState();
}

class _JoinState extends State<JoinScreen> with TickerProviderStateMixin {
  // final _formKey = GlobalKey<FormState>();

  bool isDuplicate = true; // 중복 여부를 저장할 변수
  String text = ""; // 중복 여부를 저장할 변수

  TextEditingController _nameController = TextEditingController();

  // 텍스트 입력 상자의 값이 변경될 때 호출되는 콜백 함수
  Future<void> onTextChanged(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value.length > 3 && value.length < 11) {
      bool item = (await TinjiApi().setUserName(name: value));
      setState(() {
        isDuplicate = !item; // 텍스dd트가 변경되면 중복 여부 초기화
      });
    }

    setState(() {
      text = value;
    });
  }

  // 확인 버튼이 눌렸을 때 호출되는 콜백 함수
  void onButtonPressed() async {
    String _email = await getData(EMAIL).toString();
    print(_email);

    if (text.length > 3 && text.length < 11 && isDuplicate) {
      User join = (await TinjiApi().userJoin(email: _email, name: text));
      saveData(USER_ID, join.user_id, () {
        // 데이터 저장 후 실행할 코드
        print('saveData USER_ID saved successfully');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Swipe()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: 'Join',
        backgroundColor: Colors.white,
        titleColor: Colors.black,
        onButtonPressed: () {
          print('뒤로가기 버튼이 클릭되었습니다.');
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please enter your nickname',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              onChanged: onTextChanged,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: 'Please write in 10 characters or less',

                filled: true,
                fillColor: Color(0xFFF4F4F5), // gray100
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              controller: _nameController,
              style: TextStyle(
                color: Color(0xFF09090B), // gray950
              ),
            ),
            if (text.length < 4)
              Text(' ', style: const TextStyle(color: Colors.grey))
            else if (isDuplicate)
              Text(
                '중복된 닉네임 입니다',
                style: const TextStyle(color: Colors.red),
              )
            else
              Text(
                '사용 가능한 닉네임 입니다',
                style: TextStyle(color: Colors.green),
              ),
            SizedBox(height: 16.0),
            Spacer(),
            Container(
              width: double.infinity,
              height: 56,
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                // onPressed:
                // _formKey.currentState!.validate() ? onButtonPressed : null,
                onPressed: () {
                  // Perform review submission logic here
                  String oneLineReview = _nameController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Swipe()),
                  );
                  // Use the oneLineReview and detailedReview variables to submit the review
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  'Register Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
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

class DataModel {
  final String imageUrl;
  final String title;
  final String description;
  final String address;

  DataModel(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.address});
}

void main() {
  runApp(Join());
}
