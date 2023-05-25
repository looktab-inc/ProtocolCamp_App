import 'package:flutter/material.dart';

class Player {
  String? name = 'nini';

  Player({required this.name});
}

void main() {
  var noco = Player(name: "nana");
  noco.name;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //CupertinoApp or MaterialApp
    return MaterialApp(
       home: ReviewScreen(),
    );
  }
}

class ReviewScreen extends StatelessWidget {
  TextEditingController _oneLineReviewController = TextEditingController();
  TextEditingController _detailedReviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // 뒤로 가기 버튼 동작 설정
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Create a review',
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please post a picture',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 100.0,
              height: 100.0,
              color: Colors.grey,
              child: Icon(
                Icons.add_a_photo,
                size: 50.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Please write a one-line review to evaluate the place',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _oneLineReviewController,
              decoration: InputDecoration(
                hintText: 'Please write a one-line review to evaluate the place',
                filled: true,
                fillColor: Color(0xFFF4F4F5), // gray100
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: Color(0xFF09090B), // gray950
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Please write a detailed review',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _detailedReviewController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Please write a detailed review',
                filled: true,
                fillColor: Color(0xFFF4F4F5), // gray100
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: Color(0xFF09090B), // gray950
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: .0,
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  // Perform review submission logic here
                  String oneLineReview = _oneLineReviewController.text;
                  String detailedReview = _detailedReviewController.text;
                  // Use the oneLineReview and detailedReview variables to submit the review
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  primary: Colors.black,
                ),
                child: Text(
                  'Register Review',
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
