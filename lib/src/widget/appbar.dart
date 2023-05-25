import 'package:flutter/material.dart';
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget  {
    final AppBar appBar;
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final Function onButtonPressed;

  const BaseAppBar({
    Key? key,
    required this.appBar,
    required this.title,
    required this.backgroundColor,
    required this.titleColor,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor:backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // 뒤로 가기 버튼 동작 설정
                  onButtonPressed();
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
  
  
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
