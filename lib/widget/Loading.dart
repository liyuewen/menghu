import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/utils/Screen.dart';

/*
 * 加载动画
 */
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screen.height(context),
      width: Screen.width(context),
      color: ColorConfig.WhiteBackColor,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.black87, borderRadius: BorderRadius.circular(4.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                child: Text(
                  "加载中~",
                  style: TextStyle(
                    color: ColorConfig.TextColor,
                    fontSize: 16.0,
                    decoration: TextDecoration.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
