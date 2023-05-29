import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:tinji/src/favorite/like_list.dart';
import '../candy_history/candy_history.dart'; //CandyHistory
import '../favorite/like_list.dart'; //LikeList
import '../dio.dart';
import '../data.dart';
import 'card.dart';
void main() {
  runApp(Swipe());
}


class Swipe extends StatelessWidget {
  const Swipe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinji',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SwipeScreen(),
    );
  }
}

class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
  
}

class TinderCardModel {
  final String image;
  final String name;
  final String description;

  TinderCardModel(
      {required this.image, required this.name, required this.description});
}

class _SwipeScreenState extends State<SwipeScreen>
    with TickerProviderStateMixin {

  List<TinderCardModel> cardList = [];
  int solCount = 0;
 
 @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  void fetchDataFromServer() async {
     int sol = await TinjiApi().getUserSol();

    List<dynamic> item = await TinjiApi().getMainStoreData(lat: 1.1,lng: 1.1,range: 1000);

    setState(() {
      solCount = sol;

      cardList = item.map((data) => TinderCardModel(
        image:'assets/images/test1.png',
        name: data['store_name'],
        description: data['comment'],
      )).toList();
      print(cardList);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gangnam',
                style: TextStyle(
                  fontFamily: 'Roboto Condensed',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CandyHistory()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: Row(
                            children: [
                              Icon(
                                size: (10),
                                Icons.cabin,
                                color: Color.fromARGB(255, 159, 113, 113),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${solCount}",
                                style: TextStyle(
                                  fontFamily: 'Roboto Condensed',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LikeList()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: (20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                    ),
                    child: Icon(
                      Icons.people,
                      color: Colors.white,
                      size: (20),
                    ),
                  ),
                ]),
              )
            ],
          )),
      body: Stack(
        children: <Widget>[
          for (int i = 0; i < cardList.length; i++)
            if (i == cardList.length - 1)
              Positioned.fill(
                child: DraggableCard(
                  card: cardList[i],
                  onCardSwipe: (isRightSwipe) {
                    setState(() {
                      if (isRightSwipe) {
                        // 좋아요 동작 처리
                        print('Liked ${cardList[i]}');
                      } else {
                        // 싫어요 동작 처리
                        print('Disliked ${cardList[i]}');
                      }
                      cardList.removeAt(i);
                    });
                  },
                ),
              ),
        ],
      ),
    );
  }

}

class DraggableCard extends StatefulWidget {
  final TinderCardModel card;
  final Function(bool) onCardSwipe;

  DraggableCard({required this.card, required this.onCardSwipe});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  double _dragStartX = 0.0;
  double _dragEndX = 0.0;
  bool _isSwipeRight = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    _dragStartX = details.globalPosition.dx;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final dx = details.globalPosition.dx;
    final screenWidth = MediaQuery.of(context).size.width;

    setState(() {
      _dragEndX = dx;

      if (dx > _dragStartX) {
        _isSwipeRight = true;
        final delta = dx - _dragStartX;
        _animationController.value = delta / screenWidth;
      } else {
        _isSwipeRight = false;
        final delta = _dragStartX - dx;
        _animationController.value = delta / screenWidth;
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragEndX != 0.0) {
      final screenWidth = MediaQuery.of(context).size.width;
      if ((_dragEndX - _dragStartX).abs() > (screenWidth * 0.3)) {
        // Swipe 동작 완료
        _animationController.reverse().then((value) {
          widget.onCardSwipe(_isSwipeRight);
        });
      } else {
        // Swipe 동작 취소
        _animationController.reverse();
      }

      _dragStartX = 0.0;
      _dragEndX = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: Stack(
        children: <Widget>[
          // Card(
          //   elevation: 4.0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   child: Container(
          //     // width: double.infinity,
          //     height: 150.0,
          //     width: 150,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.0),
          //       color: Color.fromARGB(96, 179, 179, 179),
          //     ),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //           Container(
          //           width: 150,
          //           height: 150,
          //           //  fit: BoxFit.cover,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(15),
          //             image: DecorationImage(
          //               image: NetworkImage(
          //                'https://img.hankyung.com/photo/202209/01.31363897.1.jpg',
          //               ),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
                 
          //         SizedBox(height: 10.0),
          //         Text(
          //           widget.card.name,
          //           style: TextStyle(
          //             fontSize: 24.0,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         SizedBox(height: 10.0),
          //         Text(
          //           widget.card.description,
          //           style: TextStyle(
          //             fontSize: 16.0,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.91, // 원하는 반투명도 값 (0.0 ~ 1.0 사이)
              child: Container(
                margin: EdgeInsets.all(24.0),
                alignment: _isSwipeRight
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      final dx = _animationController.value * 2.0 * screenWidth;
                      return Transform.translate(
                        offset: Offset(_isSwipeRight ? dx : -dx, 0.0),
                        child: child,
                      );
                    },

                    child: CardWidget(
                      id: 'Card ',
                      title: "widget.card.name",
                      content:  widget.card.description,
                      local: 'Local ',
                      distance:   widget.card.description,
                      image: 'data:image/jpeg;base64,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',
                    ),

                    // child: Card(
                    //   elevation: 4.0,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //   ),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 200.0,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       color: _isSwipeRight ? Colors.green : Colors.red,
                    //     ),
                    //     child: Center(
                    //       child: Icon(
                    //         _isSwipeRight ? Icons.favorite : Icons.close,
                    //         color: Colors.white,
                    //         size: 80.0,
                    //       ),
                    //     ),
                    //   ),
                    // ),


                    // child: Expanded(
                    //   child: Container(
                    //     height: 700,
                    //     width: 450,
                    //     margin: EdgeInsets.all(50),
                    //     padding: EdgeInsets.all(24),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(40),
                    //       ),
                    //       color: Colors.white,
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Container(
                    //                   width: 48,
                    //                   height: 48,
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(15),
                    //                     image: DecorationImage(
                    //                       image: NetworkImage(
                    //                         'assets/images/category.png',
                    //                       ),
                    //                       fit: BoxFit.cover,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 SizedBox(width: 8),
                    //                 Text(
                    //                   'Tea Well',
                    //                   style: TextStyle(
                    //                     fontFamily: 'Roboto Condensed',
                    //                     fontSize: 34,
                    //                     fontWeight: FontWeight.w700,
                    //                   ),
                    //                   textAlign: TextAlign.left,
                    //                 ),
                    //                 SizedBox(height: 4),
                    //                 Text(
                    //                   'Oriental Tea Room in the City',
                    //                   style: TextStyle(
                    //                     fontFamily: 'Roboto Condensed',
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.w400,
                    //                   ),
                    //                   textAlign: TextAlign.left,
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 4),
                    //         Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               width: 12,
                    //               height: 12,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(15),
                    //                 image: DecorationImage(
                    //                   image: NetworkImage(
                    //                     'assets/images/ic_local.png',
                    //                   ),
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(width: 2),
                    //             Text(
                    //               'Gangnam 354, 1km away',
                    //               style: TextStyle(
                    //                 fontFamily: 'Roboto Condensed',
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //               textAlign: TextAlign.left,
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 12),
                    //         Container(
                    //           margin: EdgeInsets.only(right: 20),
                    //           height: 420,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(16),
                    //             image: DecorationImage(
                    //               image: NetworkImage(widget.card.image),
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(height: 20),
                    //         Padding(
                    //           padding: EdgeInsets.symmetric(horizontal: 1),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               ElevatedButton(
                    //                 onPressed: () {},
                    //                 style: ElevatedButton.styleFrom(
                    //                   primary: Colors.white,
                    //                   elevation: 1,
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(16),
                    //                     side: BorderSide(
                    //                       color: Colors.grey,
                    //                       width: 1,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 child: Container(
                    //                   height: 40,
                    //                   width: 40,
                    //                   child: Center(
                    //                     child: Icon(
                    //                       size: (20),
                    //                       Icons.close,
                    //                       color: Color.fromARGB(
                    //                           255, 159, 113, 113),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Text(
                    //                 'View more detail',
                    //                 style: TextStyle(
                    //                   fontFamily: 'Roboto Condensed',
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w400,
                    //                 ),
                    //                 textAlign: TextAlign.left,
                    //               ),
                    //               ElevatedButton(
                    //                 onPressed: () {},
                    //                 style: ElevatedButton.styleFrom(
                    //                   primary: Colors.black,
                    //                   elevation: 0,
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(16),
                    //                   ),
                    //                 ),
                    //                 child: Container(
                    //                   height: 50,
                    //                   width: 40,
                    //                   child: Center(
                    //                     child: Icon(
                    //                       Icons.favorite,
                    //                       color: Colors.white,
                    //                       size: (20),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(height: 8),
                    //       ],
                    //     ),
                    //   ),
                    // ),


                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
