import 'dart:async';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:peach/config/_.dart';
import 'package:peach/utils/_.dart';

/*
 * 工具函数，主要给dart逻辑使用
 */
class Tool {
  /// 按照指定下标将数组分割为二维数组
  static List<List<T>> splitList<T>(List<T> list, int len) {
    if (len <= 1) {
      return [list];
    }

    List<List<T>> result = List();
    int index = 1;

    while (true) {
      if (index * len < list.length) {
        List<T> temp = list.skip((index - 1) * len).take(len).toList();
        result.add(temp);
        index++;
        continue;
      }
      List<T> temp = list.skip((index - 1) * len).toList();
      result.add(temp);
      break;
    }
    return result;
  }

  /// 生成N位随机数
  static String randomBit([int len = 15]) {
    String scopeF = '123456789'; //首位
    String scopeC = '0123456789'; //中间
    String result = '';
    for (int i = 0; i < len; i++) {
      if (i == 0) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
  }

  /// 检查用户是否有权限打开【单手模式】
  /// 权限规则：
  ///   1：对弹窗给的 androidid 进行 MD5 加密
  ///   2：在 com.example.untitled/files 文件夹中 用第一步的密文来创建文件
  ///   3：向文件中 写入 设备的 androidid
  ///   通过验证，正常访问..
  static Future<bool> checkIsOpen() async {
    String androidId = Config.androidDeviceInfo.androidId;
    Directory filesPath = await getExternalStorageDirectory();
    File completePath = File("${filesPath.path}/${generateMd5(androidId)}");
    if (completePath.existsSync()) {
      String textMessage = await completePath.readAsString();
      return textMessage == androidId ? true : false;
    } else {
      return false;
    }
  }

  /*
   * md5 加密
   */
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  /// 从本地读取用户信息
  static Map userInfo() {
    String username = SPreferences().getString("username");
    String objectId = SPreferences().getString("objectId");
    String createdAt = SPreferences().getString("createdAt");
    String userType = SPreferences().getString("userType");
    String userWeiXin = SPreferences().getString("userWeiXin");
    Map info = new Map();
    info.addAll({
      'username': username,
      'objectId': objectId,
      'createdAt': createdAt,
      'userType': userType,
      'userWeiXin': userWeiXin,
    });
    return info;
  }

  /// 验证是否为合法的手机号
  static bool isPhone(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }

  // 防抖
  // // const Duration(milliseconds: 2000)
  static debounce(Function func, Duration mill) {
    Timer timer;
    Duration delay = mill;
    Function target = () {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      timer = Timer(delay, () {
        func?.call();
      });
    };
    return target;
  }

  /*  时间戳转字符串
    * timestamp 时间戳
    * formart ："y-m":年和月之间的符号,
    * "m-d":月和日之间的符号
    * "h-m":时和分之间的符号,
    * "m-s":分和秒之间的符号；
    * "m-a":是否显示上午和下午
    */
  static String dateAndTimeToString(var timestamp,
      {Map<String, String> formart}) {
    if (timestamp == null || timestamp == "") {
      return "";
    }
    String targetString = "";
    final date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    // final String tmp = date.toString();
    String year = date.year.toString();
    String month = date.month.toString();
    if (date.month <= 9) {
      month = "0" + month;
    }
    String day = date.day.toString();
    if (date.day <= 9) {
      day = "0" + day;
    }
    String hour = date.hour.toString();
    if (date.hour <= 9) {
      hour = "0" + hour;
    }
    String minute = date.minute.toString();
    if (date.minute <= 9) {
      minute = "0" + minute;
    }
    String second = date.second.toString();
    if (date.second <= 9) {
      second = "0" + second;
    }
    // String millisecond = date.millisecond.toString();
    String morningOrafternoon = "上午";
    if (date.hour >= 12) {
      morningOrafternoon = "下午";
    }

    if (formart["y-m"] != null && formart["m-d"] != null) {
      targetString = year + formart["y-m"] + month + formart["m-d"] + day;
    } else if (formart["y-m"] == null && formart["m-d"] != null) {
      targetString = month + formart["m-d"] + day;
    } else if (formart["y-m"] != null && formart["m-d"] == null) {
      targetString = year + formart["y-m"] + month;
    }

    targetString += " ";

    if (formart["m-a"] != null) {
      targetString += morningOrafternoon + " ";
    }

    if (formart["h-m"] != null && formart["m-s"] != null) {
      targetString += hour + formart["h-m"] + minute + formart["m-s"] + second;
    } else if (formart["h-m"] == null && formart["m-s"] != null) {
      targetString += minute + formart["m-s"] + second;
    } else if (formart["h-m"] != null && formart["m-s"] == null) {
      targetString += hour + formart["h-m"] + minute;
    }

    return targetString;
  }

  /*
  * 2021-05-22T10:37:06.000+00:00 => 1621679826000
  * 把标准时间格式转换成时间戳 
  */
  static int timeToStamp(String str) {
    String _time = str;
    int _intendtime = DateTime.parse(_time).millisecondsSinceEpoch;
    return _intendtime;
  }
}
