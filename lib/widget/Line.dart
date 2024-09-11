import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/utils/Screen.dart';

/*
 * 大部分布局的左右上下宽高都是固定的所以单独抽一个面板组件
 */
class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: Screen.width(context),
      color: ColorConfig.LineColor,
    );
  }
}
