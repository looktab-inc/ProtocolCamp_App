import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final String local;
  final String distance;
  final String image;

  const CardWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    required this.local,
    required this.distance,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/ic_category_main.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto Condensed',
                fontSize: 30.0,
                fontWeight: FontWeight.w800,

              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 2.0),
            Text(
              content,
              style: TextStyle(
                fontFamily: 'Roboto Condensed',
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),

            SizedBox(height: 4.0),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/ic_local.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 4.0),
                Text(
                  local,
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 360.0, // 카드의 높이에 맞추기
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                image: DecorationImage(
                  image: NetworkImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Image.network(
            //         image,
            //         fit: BoxFit.cover,
            //         height: MediaQuery.of(context).size.height - 350.0, // 카드의 높이에 맞추기
            //         width: double.infinity,
            //       ),
          ],
        ),
      ),
    );
  }
}

class YourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100.0),
          CardWidget(
              id: 'Card ',
              title: 'Title ',
              content: 'Content ',
              local: 'Local ',
              distance: 'Distance ',
              image:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnmjfAjZABMl0e6_TRecH3zf5jAkk__cUpPQ&usqp=CAU'),
          SizedBox(height: 100.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 버튼 1 동작
                },
                child: Text('Button 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 버튼 2 동작
                },
                child: Text('Button 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 버튼 3 동작
                },
                child: Text('Button 3'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: YourScreen(),
//   ));
// }
