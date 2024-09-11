import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/utils/_.dart';

/*
 * 数据为空时默认展示
 */
class Empty extends StatelessWidget {
  final double height;
  final Widget child;
  final bool isShow;

  Empty({this.height = 100, this.child = null, this.isShow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screen.width(context),
      height: height,
      child: isShow
          ? Container(
              padding: EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(
                    Icons.drafts,
                    size: 52,
                    color: ColorConfig.TextColor,
                  ),
                  Text("暂无数据")
                ],
              ),
            )
          : this.child,
    );
  }
}
