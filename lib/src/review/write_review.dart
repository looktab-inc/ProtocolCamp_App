import 'package:flutter/material.dart';
import 'package:tinji/src/widget/appbar.dart';

class Player {
  String? name = 'nini';

  Player({required this.name});
}

void main() {
  var noco = Player(name: "nana");
  noco.name;
  runApp(ReviewWrite());
}

class ReviewWrite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinji',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReviewWriteScreen(),
    );
  }
}

class ReviewWriteScreen extends StatefulWidget {
  @override
  _ReviewWriteState get createState => _ReviewWriteState();
}

class _ReviewWriteState extends State<ReviewWriteScreen> {
  TextEditingController _oneLineReviewController = TextEditingController();
  TextEditingController _detailedReviewController = TextEditingController();

  // File? selectedImage; // Change the type to File?

  // Future<void> _selectImage() async {
  //   final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       // selectedImage = File(pickedImage.path as List<Object>,"name"); // Create File instance from pickedImage.path
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: 'Create a review',
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
              'Please post a picture',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            InkWell(
              // onTap: () async {
              //   _selectImage();
              //   final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
              //     if (pickedImage != null) {
              //       // 이미지 선택 후의 작업 수행
              //       // pickedImage 변수에 선택한 이미지 정보가 담겨 있습니다.
              //     }
              // },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/photo_empty.png'),
                    fit: BoxFit.cover,
                  ),
                ),
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
                hintText:
                    'Please write a one-line review to evaluate the place',
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
              minLines: 6,
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
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // String oneLineReview = _nameController.text;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
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
