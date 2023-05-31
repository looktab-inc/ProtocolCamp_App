import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duplicate Word Checker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState get createState => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userInput = ''; // 입력된 텍스트를 저장할 변수
  bool isDuplicate = false; // 중복 여부를 저장할 변수

  // 서버 API를 호출하여 중복된 단어인지 확인하는 함수
  Future<bool> checkDuplicateWord(String word) async {
    // 서버 API 호출 로직을 구현하세요
    // 예를 들어, http 패키지를 사용하여 POST 요청을 보내고 응답을 분석할 수 있습니다.
    // 이 예시에서는 단순히 "example.com"으로 요청을 보내고 응답을 받은 것으로 가정합니다.
    var response = await http.post(Uri.parse('http://example.com'));
    // 응답을 분석하여 중복 여부를 판단합니다.
    return response.statusCode == 200;
  }

  // 텍스트 입력 상자의 값이 변경될 때 호출되는 콜백 함수
  void onTextChanged(String value) {
    setState(() {
      userInput = value;
      isDuplicate = false; // 텍스트가 변경되면 중복 여부 초기화
    });
  }

  // 확인 버튼이 눌렸을 때 호출되는 콜백 함수
  void onButtonPressed() async {
    if (userInput.length >= 3 && userInput.length <= 10) {
      // 입력된 텍스트의 길이가 유효한 범위인지 확인
      bool isDuplicateWord = await checkDuplicateWord(userInput);
      setState(() {
        isDuplicate = isDuplicateWord;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duplicate Word Checker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: onTextChanged,
              decoration: InputDecoration(
                labelText: '단어 입력 (3~10자)',
              ),
            ),
            SizedBox(height: 10),
            if (isDuplicate)
              Text(
                '중복된 닉네임',
                style: TextStyle(color: Colors.red),
              )
            else if (userInput.isNotEmpty)
              Text(
                '사용 가능',
                style: TextStyle(color: Colors.green),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: userInput.length >= 3 && userInput.length <= 10
                  ? onButtonPressed
                  : null, // 길이가 유효한 경우에만 버튼 활성화
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
