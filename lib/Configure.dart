import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:peach/utils/_.dart';
import 'config/_.dart';
import 'package:device_info/device_info.dart';

/*
 * 各种工具和配置的初始化
 */
class Configure {
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // SharedPreferences 初始化
    await SPreferences.init();

    // 是否第一次打开的判断
    Config.isFirstOpen = !SPreferences().getBool("isFirstOpen");

    // 是否第一次打开的判断
    Config.isLogin = !SPreferences().getIsLogin();

    // 初始化事件控制中心
    Config.eventBus = EventBus();

    // 读取保存设备信息
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Config.isAndroid
        ? Config.androidDeviceInfo = await deviceInfoPlugin.androidInfo
        : Config.iosDeviceInfo = await deviceInfoPlugin.iosInfo;

    // 保存App软件包信息
    Config.packageInfo = await PackageInfo.fromPlatform();
  }
}
