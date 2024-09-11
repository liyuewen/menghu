import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/utils/_.dart';

/*
 * 数据为空时默认展示 text
 */
class EmptyText extends StatelessWidget {
  final double height;
  final String text;

  EmptyText({
    this.height = 100,
    this.text = "暂无数据",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screen.width(context),
      height: height,
      alignment: Alignment.center,
      child: Text(this.text),
    );
  }
}
