import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class Shop extends StatelessWidget {
  final String shopId;

  const Shop({
    Key? key,
    required this.shopId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinji',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShopScreen(shopId),
    );
  }
}

class ShopScreen extends StatefulWidget {
  late String shopId;

  ShopScreen(this.shopId);

  @override
  _ShopScreenState get createState => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  List<DataModel> reviewList = [
    DataModel(
      imageUrl:
          'https://ak-d.tripcdn.com/images/1i61n22349cq8e77lB883_W_670_10000.jpg',
      title: "title",
      description: "dddddd",
    ),
    DataModel(
      imageUrl:
          'https://ak-d.tripcdn.com/images/1i65722349cq8eexcAADC_W_670_10000.jpg',
      title: "title",
      description: "dddddd",
    ),
    DataModel(
      imageUrl:
          'https://ak-d.tripcdn.com/images/1i62z2224t9d2bnrkBAC3_W_670_10000.jpg',
      title: "title",
      description: "dddddd",
    )
  ];

  // late  StoreData store;
  StoreData store = StoreData(
    name: "name",
    description: "description",
    address: "address",
    nftAddress: "nftAddress",
    howToReach: "howToReach",
    latitude: 1,
    longitude: 2,
    openTime: "openTime",
    closeTime: "closeTime",
    closeDays: 3,
    image: "asdf",
  );

  @override
  void initState() {
    super.initState();
    fetchDataFromServer(widget.shopId);
  }

  void fetchDataFromServer(shopId) async {
    dynamic storeData = await TinjiApi().getStore(store_id: shopId);
    List<dynamic> review1 = await TinjiApi().getStoreReview(store_id: shopId);
    // List<dynamic> review2 = await TinjiApi().getStoreLikeReview(store_id: shopId);

    setState(() {
      store = StoreData(
        name: storeData['name'] ??= 'Tea Well',
        description: storeData['description'] ??=
            'Oriental Tea Room in the City',
        address: storeData['address'] ??= 'Gangnam  354, 1km away',
        nftAddress: storeData['nftAddress'] ??= '0x000',
        howToReach: storeData['howToReach'] ??= '2,000',
        latitude: storeData['latitude'] ??= 1,
        longitude: storeData['longitude'] ??= 2,
        openTime: storeData['openTime'] ??= '11:00',
        closeTime: storeData['closeTime'] ??= '22:00',
        closeDays: storeData['closeDays'] ??= 3,
        image: storeData['image'],
      );

      var item1 = review1
          .map((data) => DataModel(
                imageUrl:
                    'https://ak-d.tripcdn.com/images/1i62z2224t9d2bnrkBAC3_W_670_10000.jpg',
                title: data['user_id'],
                description: data['content'],
              ))
          .toList();

      reviewList = item1;
    });
  }

  List<String> images = [
    'https://ak-d.tripcdn.com/images/1i62z2224t9d2bnrkBAC3_W_670_10000.jpg',
    'https://avatars.githubusercontent.com/u/18034145?v=4',
    'https://ak-d.tripcdn.com/images/1i61n22349cq8e77lB883_W_670_10000.jpg',
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 480,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            items: images.map((image) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
          Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Text(
                  store.name ??= "Tinji",
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 38,
              margin: EdgeInsets.only(
                  top: 420, left: MediaQuery.of(context).size.width / 2 - 28),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentPage == index ? Colors.white : Colors.grey,
                      ),
                    );
                  }),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 450),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.name ??= 'your_default_value',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 4),
                            Text(
                              store.description ??=
                                  'Oriental Tea Room in the City',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/category.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.asset(
                        //    'assets/images/ic_local.png',
                        //   width: 12,
                        //   height: 12,
                        // ),
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
                        SizedBox(width: 2),
                        Text(
                          store.address ??= "Gangnam  354, 1km away",
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'It was quite quiet and atmospheric. There were many kinds of tea, so it was fun to choose. If you want to introduce a good place to an acquaintance and talk calmly, I recommend this place.',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    index == 0 ? 'Created date' : 'nft_address',
                                    style: TextStyle(
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 2),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    index == 0
                                        ? "${store.openTime?.substring(0, 2)}-${store.closeTime?.substring(0, 2)}"
                                        : '${store.nftAddress}',
                                    style: TextStyle(
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Container(
                      child: Text(
                        'Review',
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          letterSpacing: 0.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: reviewList.length,
                            itemBuilder: (context, index) {
                              final data = reviewList[index];

                              return Card(
                                margin: EdgeInsets.only(bottom: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 20),
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "/assets/images/gray.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.title,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto Condensed',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          39, 39, 42, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    data.description,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto Condensed',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromRGBO(
                                                          113, 113, 122, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            data.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ]),
                              );

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    index == 0 ? 'Created date' : 'nft_address',
                                    style: TextStyle(
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    index == 0
                                        ? "${store.openTime?.substring(0, 2)}-${store.closeTime?.substring(0, 2)}"
                                        : '${store.nftAddress}',
                                    style: TextStyle(
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class StoreData {
  String? name;
  String? description;
  String? address;
  String? nftAddress;
  String? howToReach;
  double? latitude;
  double? longitude;
  String? openTime;
  String? closeTime;
  int? closeDays;
  String? image;

  StoreData({
    required this.name,
    required this.description,
    required this.address,
    required this.nftAddress,
    required this.howToReach,
    required this.latitude,
    required this.longitude,
    required this.openTime,
    required this.closeTime,
    required this.closeDays,
    required this.image,
  });
}

class DataModel {
  final String imageUrl;
  final String title;
  final String description;

  DataModel(
      {required this.imageUrl, required this.title, required this.description});
}

void main() {
  runApp(Shop(
    shopId: "5ATS7F",
  ));
}
