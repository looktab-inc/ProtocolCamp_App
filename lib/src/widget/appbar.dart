import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
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
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pop();
              // 버튼이 클릭되었을 때 실행할 코드 작성
              print('Button clicked!');
              onButtonPressed();
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
           IconButton(
            icon: Icon(null),
            onPressed: () {
              // 뒤로 가기 버튼 동작 설정
              onButtonPressed();
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
