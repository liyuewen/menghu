import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/utils/_.dart';

/*
 * 关注按钮样式
 */
class FollowButton extends StatelessWidget {
  final bool isCheck;
  final Function onPressed;

  const FollowButton({this.isCheck, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return isCheck
        ? ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  //设置按下时的背景颜色
                  if (states.contains(MaterialState.pressed)) {
                    return ColorConfig.AshPlacement;
                  }
                  //默认不使用背景颜色
                  return ColorConfig.AshPlacement;
                },
              ),
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text(
              "已关注",
              style: TextStyle(fontSize: 15, letterSpacing: 2,color: ColorConfig.TextColor),
            ),
            onPressed: () {
              onPressed();
            },
          )
        : ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  //设置按下时的背景颜色
                  if (states.contains(MaterialState.pressed)) {
                    return ColorConfig.ThemeOtherColor;
                  }
                  //默认不使用背景颜色
                  return ColorConfig.ThemeColor;
                },
              ),
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text(
              "关注",
              style: TextStyle(fontSize: 15, letterSpacing: 2, color: ColorConfig.WhiteBackColor),
            ),
            onPressed: () {
              onPressed();
            },
          );
  }
}
