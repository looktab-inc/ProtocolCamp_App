import 'package:flutter/material.dart';

void main() {
  runApp(TinderApp());
}

class TinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinji',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TinderScreen(),
    );
  }
}

class TinderScreen extends StatefulWidget {
  @override
  _TinderScreenState createState() => _TinderScreenState();
}

class TinderCardModel {
  final String image;
  final String name;
  final String description;

  TinderCardModel(
      {required this.image, required this.name, required this.description});
}

class _TinderScreenState extends State<TinderScreen>
    with TickerProviderStateMixin {
  List<TinderCardModel> cardList = [
    TinderCardModel(
      image: 'assets/images/test1.png',
      name: 'Card 1',
      description: 'Description 1',
    ),
    TinderCardModel(
      image: 'assets/images/test1.png',
      name: 'Card 2',
      description: 'Description 2',
    ),
    TinderCardModel(
      image: 'assets/images/test2.png',
      name: 'Card 3',
      description: 'Description 3',
    ),
    TinderCardModel(
      image: 'assets/images/test2.png',
      name: 'Card 4',
      description: 'Description 4',
    ),
  ];
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
                    onPressed: () {},
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
                                '100',
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
                    onPressed: () {},
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
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              // width: double.infinity,
              height: 150.0,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color.fromARGB(96, 179, 179, 179),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    widget.card.image,
                    // width: double.infinity,
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.card.name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.card.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 1, // 원하는 반투명도 값 (0.0 ~ 1.0 사이)
              child: Container(
                alignment: _isSwipeRight
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: SizedBox(
                  width: double.infinity,
                  height: 800.0,
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
                    //         child: Icon(
                    //           _isSwipeRight ? Icons.favorite : Icons.close,
                    //           color: Colors.white,
                    //           size: 80.0,
                    //         ),
                    //     ),
                    //   ),
                    // ),

                    child: Expanded(
                      child: Container(
                        height: 700,
                        width: 450,
                        margin: EdgeInsets.all(50),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'assets/images/category.png',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Tea Well',
                                      style: TextStyle(
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 34,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Oriental Tea Room in the City',
                                      style: TextStyle(
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'assets/images/ic_local.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  'Gangnam 354, 1km away',
                                  style: TextStyle(
                                    fontFamily: 'Roboto Condensed',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              height: 420,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(widget.card.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
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
                                        child: Icon(
                                          size: (20),
                                          Icons.close,
                                          color: Color.fromARGB(
                                              255, 159, 113, 113),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'View more detail',
                                    style: TextStyle(
                                      fontFamily: 'Roboto Condensed',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Container(
                                      height: 50,
                                      width: 40,
                                      child: Center(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: (20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
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