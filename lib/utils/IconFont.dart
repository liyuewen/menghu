import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';

/*
 * IconFont 字体图标
 */
class IconFont {
  static Icon LogoIcon(
      {double size = 24.0, Color color = ColorConfig.WhiteBackColor}) {
    return Icon(
      const IconData(0xe61c, fontFamily: 'iconfont'),
      size: size,
      color: color,
    );
  }
}
