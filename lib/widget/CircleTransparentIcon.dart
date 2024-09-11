import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/Colors.dart';
import 'package:peach/config/Index.dart';
import 'package:peach/utils/_.dart';

/*
 * 圆形背景的icon
 */
class CircleTransparentIcon extends StatelessWidget {
  final Widget icon;

  const CircleTransparentIcon({this.icon});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: CircleAvatar(
        backgroundColor: ColorConfig.BlackBackColor,
        child: Align(
          alignment: Alignment.center,
          child: this.icon,
        ),
      ),
    );
  }
}
