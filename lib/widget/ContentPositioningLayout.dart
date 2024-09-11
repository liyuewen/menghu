import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/config/Index.dart';
import 'package:peach/utils/_.dart';

/*
 * 接受头部和内容，当页面向上滑动时内容部分到达顶部会定位
 * 并且当到达顶部是会触发回调函数
 */
class ContentPositioningLayout extends StatelessWidget {
  final Widget title;
  final Widget child;
  final double titleHeight;
  final double scrollHeight;

  const ContentPositioningLayout(
      {this.title, this.child, this.titleHeight = 45, this.scrollHeight = 0});

  static Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    ScrollController mController = new ScrollController();
    mController.addListener(() {
      if (scrollHeight == 0) {
        return;
      }
      if ((scrollHeight.truncate() - mController.offset.truncate()) <= 3) {
        color = ColorConfig.WhiteBackColor;
      } else {
        color = Colors.transparent;
      }
    });
    return Stack(
      children: <Widget>[
        Positioned(
          height: Screen.height(context),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: mController,
            child: this.child,
          ),
        ),
        Positioned(
          height: Screen.setHeight(this.titleHeight) + Config.top,
          child: Container(
            padding: EdgeInsets.only(top: Config.top),
            decoration: BoxDecoration(color: color),
            child: this.title,
          ),
        ),
      ],
    );
  }
}
