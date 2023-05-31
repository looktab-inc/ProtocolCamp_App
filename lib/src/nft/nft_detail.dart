import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tinji/src/review/write_review.dart';
import 'package:tinji/src/shop/shop.dart';

import 'NftModel.dart';

class NftDetail extends StatelessWidget {
  final NftModel model;

  const NftDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinji',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NftDetailScreen(model),
    );
  }
}

class NftDetailScreen extends StatefulWidget {
  late NftModel nftModel;

  NftDetailScreen(this.nftModel);

  @override
  _NftDetailState get createState => _NftDetailState();
}

class _NftDetailState extends State<NftDetailScreen> {
  late NftModel nftModel;

  @override
  void initState() {
    super.initState();
    nftModel = widget.nftModel;
  }

  List<String> images = [
    'https://avatars.githubusercontent.com/u/18034145?v=4',
    'https://avatars.githubusercontent.com/u/18034145?v=4',
    'https://avatars.githubusercontent.com/u/18034145?v=4',
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
                  nftModel.storeName,
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
          Container(
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
                      color: _currentPage == index ? Colors.white : Colors.grey,
                    ),
                  );
                }),
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
                              nftModel.storeName,
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 4),
                            Text(
                              nftModel.description,
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
                          nftModel.address,
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
                                    nftModel.time,
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Shop(shopId: nftModel.shopId)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            minimumSize: Size(
                              (MediaQuery.of(context).size.width - 24) / 2 - 8,
                              56,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 56,
                            child: const Text(
                              'View more detail',
                              style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewWrite()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.zero,
                            minimumSize: Size(
                              (MediaQuery.of(context).size.width - 24) / 2 - 8,
                              56,
                            ),
                          ),
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/1398/1398500.png',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Create a review',
                                  style: TextStyle(
                                    fontFamily: 'Roboto Condensed',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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

void main() {
  // runApp(NftDetail());
  NftModel moel = NftModel(
      nftAddress: " data['nft_address']",
      storeName: " data['nft_address']",
      description: " data['nft_address']",
      address: " data['nft_address']",
      shopId: "5ATS7F",
      time: " data['nft_address']",
      visited: 0,
      image: [""]);

  runApp(NftDetail(model: moel));
}
