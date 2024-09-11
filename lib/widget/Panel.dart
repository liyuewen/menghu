import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/utils/Screen.dart';

/*
 * 大部分布局的左右上下宽高都是固定的所以单独抽一个面板组件
 */
class Panel extends StatelessWidget {
  final double top;
  final double bottom;
  final Widget child;

  const Panel({this.child, this.top = 10.0, this.bottom = 10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screen.width(context),
      child: Padding(
          padding: EdgeInsets.only(
              left: 10, right: 10, top: this.top, bottom: this.bottom),
          child: this.child),
    );
  }
}
