import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tinji/src/review/write_review.dart';
import 'package:tinji/src/shop/shop.dart';

import '../data.dart';
import '../widget/appbar.dart';
import 'package:intl/intl.dart';

class CandyHistory extends StatelessWidget {
  const CandyHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CandyHistoryScreen(),
    );
  }
}

class CandyHistoryScreen extends StatefulWidget {
  @override
  _CandyHistoryState get createState => _CandyHistoryState();
}

class History {
  String? comment;
  String? title;
  int? amount;
  String? date;
  String? time;
  History({
    required this.comment,
    required this.title,
    required this.amount,
    required this.date,
    required this.time,
  });
}

class _CandyHistoryState extends State<CandyHistoryScreen> {
  var candyCount = 0;
  late List<History> history ;


  @override
  void initState() {
    super.initState();
    getHistoryData();
  }

  Future<void> getHistoryData() async {
    double sol = await TinjiApi().getUserSol();
    List<dynamic> data = await TinjiApi().getHistory();
    
    setState(() {
      candyCount = (sol*10000) as int;
      history = data
          .map((data) => History(
              comment: data['comment'].split(" ")[0],
              title: data['comment'].split(" ").sublist(1).join(' ').toString(),
              time: DateFormat('HH:mm').format(DateTime.parse(data['date'])),
              date:  DateFormat('yyyy-MM-dd').format(DateTime.parse(data['date'])),
              amount: data['amount'])
              )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Container(
      color: Colors.black,
      child: Stack(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(width: 24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 130),
                  Text(
                    'My Candy',
                    style: TextStyle(
                        color: Color.fromARGB(207, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 6),
                  Text(
                    candyCount.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xFFFF7051),
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    textAlign: TextAlign.left,
                    (candyCount * 0.031).toString(),
                    style: TextStyle(
                        color: Color.fromARGB(122, 255, 255, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(top: 100),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/candyBox.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 82),
          ]),
          Container(
            margin: EdgeInsets.only(top: 52),
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    // 버튼이 클릭되었을 때 실행할 코드 작성
                    print('Button clicked!');
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/back_white.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Candy history",
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 250),
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
                        Text(
                          "History",
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'How withdrawal?',
                          style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.19,
                            decoration: TextDecoration.underline,
                            color: Color(0xFFA1A1AA),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '2023.05.12',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1,
                        color: Color(0xFF71717A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              final data = history[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 8),
                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.circular(16),
                                // ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/images/category.png',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        SizedBox(width: 8),
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.title ??=  "Store Review NFT",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto Condensed',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xFF27272A),
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    data.time ??= "13:20",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto Condensed',
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      height: 1,
                                                      color: Color(0xFF71717A),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 1),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "+${data.amount} Candy",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto Condensed',
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                      height: 1,
                                                      color: Color(0xFFEC5F40),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    data.comment ??= "Rewards",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto Condensed',
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      height: 1,
                                                      color: Color(0xFF71717A),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                    ]),
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
    )));
  }
}

void main() {
  runApp(CandyHistory());
}
