import 'package:flutter/cupertino.dart';
import 'package:peach/config/_.dart';

/*
 * 底部弹出操作栏 
 */
class RoutineShowDialog {
  static itemShowDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                '复制链接',
                style: TextStyle(
                  color: ColorConfig.ThemeColor,
                  fontSize: 16,
                ),
              ),
              onPressed: () {},
              isDefaultAction: true,
            ),
            CupertinoActionSheetAction(
              child: Text(
                '分享',
                style: TextStyle(
                  color: ColorConfig.ThemeColor,
                  fontSize: 16,
                ),
              ),
              onPressed: () {},
              isDefaultAction: true,
            ),
            CupertinoActionSheetAction(
              child: Text(
                '举报',
                style: TextStyle(
                  color: ColorConfig.ThemeColor,
                  fontSize: 16,
                ),
              ),
              onPressed: () {},
              isDefaultAction: true,
            ),
            CupertinoActionSheetAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {},
              isDestructiveAction: true,
            ),
          ],
        );
      },
    );
  }
}
