import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/utils/Screen.dart';

/*
 * 组件加载时的动画
 */
class PageAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screen.height(context),
      width: Screen.width(context),
      child: CupertinoActivityIndicator(
        radius: 10,
      ),
      color: ColorConfig.WhiteBackColor,
    );
  }
}
