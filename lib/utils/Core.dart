import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
 * 核心的utils，主要封装UI相关的操作
 */
class Core {
  //修改状态栏颜色
  static void barColor(Color color) {
    SystemUiOverlayStyle uiStyle = SystemUiOverlayStyle.light.copyWith(
      statusBarColor: color,
    );
    SystemChrome.setSystemUIOverlayStyle(uiStyle);
  }

  /// 复制文字到剪切板
  static void copy(String message) {
    Clipboard.setData(ClipboardData(text: message));
  }
}
