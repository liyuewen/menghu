import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
 * 尺寸兼容，类似前端的rem
 */
class Screen {
  static double setWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static double setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static double setFontSize(double Size) {
    return ScreenUtil().setSp(Size);
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
