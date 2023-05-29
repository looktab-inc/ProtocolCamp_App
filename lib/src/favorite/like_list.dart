import 'package:flutter/material.dart';

class LikeList extends StatelessWidget {
  const LikeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                
                // 뒤로 가기 버튼 동작 설정
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Like',
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];
          return Card(
            margin: EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(data.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          data.description,
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          data.address,
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://cdn-icons-png.flaticon.com/512/1398/1398500.png',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '방문하고 캔디받기',
                                  style: TextStyle(
                                    fontFamily: 'Roboto Condensed',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DataModel {
  final String imageUrl;
  final String title;
  final String description;
  final String address;

  DataModel({required this.imageUrl, required this.title, required this.description, required this.address});
}

final dataList = [
  DataModel(
    imageUrl: 'https://avatars.githubusercontent.com/u/18034145?v=4',
    title: 'TeaWell',
    description: 'Oriental Tea Room in the City',
    address: 'Gangnam 354, 1km away',
  ),
  DataModel(
    imageUrl: 'https://avatars.githubusercontent.com/u/18034145?v=4',
    title: 'TeaWell',
    description: 'Oriental Tea Room in the City',
    address: 'Gangnam 354, 1km away',
  ),
  DataModel(
    imageUrl: 'https://avatars.githubusercontent.com/u/18034145?v=4',
    title: 'TeaWell',
    description: 'Oriental Tea Room in the City',
    address: 'Gangnam 354, 1km away',
  ),
  DataModel(
    imageUrl: 'https://avatars.githubusercontent.com/u/18034145?v=4',
    title: 'TeaWell',
    description: 'Oriental Tea Room in the City',
    address: 'Gangnam 354, 1km away',
  ),
  DataModel(
    imageUrl: 'https://avatars.githubusercontent.com/u/18034145?v=4',
    title: 'TeaWell',
    description: 'Oriental Tea Room in the City',
    address: 'Gangnam 354, 1km away',
  ),
  DataModel(
    imageUrl: 'https://avatars.githubusercontent.com/u/18034145?v=4',
    title: 'TeaWell',
    description: 'Oriental Tea Room in the City',
    address: 'Gangnam 354, 1km away',
  ),
  DataModel(
    imageUrl: 'https://avatars.githubusercontent.com/u/18034145?v=4',
    title: 'TeaWell',
    description: 'Oriental Tea Room in the City',
    address: 'Gangnam 354, 1km away',
  ),
  // Add more data entries as needed
];

void main() {
  runApp(MaterialApp(
    home: LikeList(),
  ));
}
