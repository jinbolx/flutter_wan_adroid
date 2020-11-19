import 'package:flutter/material.dart';

class ArticleTag extends StatelessWidget {
  final String text;
  final Color color;

  ArticleTag({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    var themeColor = color ?? Theme.of(context).accentColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      margin: EdgeInsets.only(right: 5,bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: themeColor),
      ),
      child: Text(
        text,
        style: TextStyle(color: themeColor, fontSize: 10),
      ),
    );
  }
}
