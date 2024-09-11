import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:peach/config/_.dart';

/*
 * 动态申请App的权限
 */
class AuthorityApplication {
  /// App需要动态申请的权限
  static List<Permission> permissionList = [
    Permission.storage,
    Permission.photos
  ];

  static Future<bool> init(BuildContext context) async {
    if (Config.isAndroid) {
      Map<Permission, PermissionStatus> status = await permissionList.request();
      if (status[Permission.storage].isGranted) {
        print("用户同意了权限");
        return true;
      } else if (status[Permission.storage].isDenied) {
        print("用户拒绝了权限");
        AuthorityApplication.ShowTips(
          context: context,
          content: "请允许App获取权限，否则App功能不能正常使用！",
          isShowcancel: false,
          confirmCall: () async {
            AuthorityApplication.init(context);
          },
        );
        return false;
      } else if (status[Permission.storage].isPermanentlyDenied) {
        print("用户永久拒绝了权限");
        AuthorityApplication.ShowTips(
          context: context,
          content: "您禁用了应用的必要权限，请到设置里开启！",
          isShowcancel: false,
          confirmText: '打开设置',
          confirmCall: () async {
            await openAppSettings();
          },
        );
        return false;
      }
    }
  }

  static Future ShowTips(
      {BuildContext context,
      String content,
      bool isShowcancel: true,
      Function confirmCall,
      confirmText = "重新请求",
      title = '提示'}) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  isShowcancel
                      ? FlatButton(
                          child: Text(
                            '取消',
                            style: TextStyle(color: ColorConfig.NoActiveColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                      : Text(''),
                  FlatButton(
                      child: Text(
                        confirmText,
                        style: TextStyle(color: ColorConfig.ThemeColor),
                      ),
                      onPressed: () async {
                        confirmCall();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ));
  }
}
