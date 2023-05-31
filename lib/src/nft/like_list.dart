import 'package:flutter/material.dart';
import 'package:tinji/src/widget/appbar.dart';

import '../data.dart';
import 'NftModel.dart';
import 'nft_detail.dart';

class LikeList extends StatelessWidget {
  const LikeList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinji',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LikeListScreen(),
    );
  }
}

class LikeListScreen extends StatefulWidget {
  @override
  _LikeListScreenState get createState => _LikeListScreenState();
}

class _LikeListScreenState extends State<LikeListScreen>
    with TickerProviderStateMixin {
  List<NftModel> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  void fetchDataFromServer() async {
    List<dynamic> item = await TinjiApi().getUserLikeStores();

    setState(() {
      dataList = item
          .map((data) => NftModel(
              nftAddress: " data['nft_address']",
              storeName: data['storeInfo']['name'],
              description: data['rec_data']['comment'],
              address: data['storeInfo']['address'],
              shopId: data['storeInfo']['id'],
              time:
                  "${data['storeInfo']['open_time']}${data['storeInfo']['close_time']}",
              visited: data['visited'],
              image: [data['rec_data']['img1']]))
          .toList();
      print(dataList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];
          return Card(
            margin: EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(data.image[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.storeName,
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          data.description,
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
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
                              data.address,
                              style: TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromRGBO(161, 161, 170, 1)),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NftDetail(model: data)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            height: 40,
                            width: double.infinity,
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
                                    'Visit and get candy',
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

void main() {
  runApp(LikeList());
}
// void main() {
//   runApp(MaterialApp(
//     home: LikeList(),
//   ));
// }
