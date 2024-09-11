import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/utils/_.dart';

/*
 * 只做展示作用的 搜索框
 */
class ExhibitionSearch extends StatelessWidget {
  final controller = TextEditingController();

  final double height;
  final Color backgroundColor;

  ExhibitionSearch(
      {this.height = 28, this.backgroundColor = ColorConfig.WhiteBackColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screen.setHeight(this.height),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.search,
              color: ColorConfig.TextColor,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                "搜索动态",
                style: TextStyle(color: ColorConfig.TextColor, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
