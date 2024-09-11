import 'dart:io';
import 'package:event_bus/event_bus.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:peach/R.dart';
import 'package:peach/utils/_.dart';

import 'Colors.dart';

class Config {
  static double top = MediaQueryData.fromWindow(window).padding.top;

  /// 第一次打开，本地无值，返回false取反为true所以显示welcome
  /// 第二次打开，本地有值，返回true取反false，所以显示app页面
  static bool isFirstOpen = false;

  /// 第一次打开，未登录，本地无值，返回false，取反为true，访问登录页面
  /// 第二次打开，已登录，本地有值，返回true，取反为返回false，访问app页面
  static bool isLogin = true;

  /// App 的名字
  static String appName = "萌弧";

  /// 保存 App安装包信息
  static PackageInfo packageInfo;

  /// 是否为 android
  static bool isAndroid = Platform.isAndroid;

  /// 保存 android 设备信息
  static AndroidDeviceInfo androidDeviceInfo;

  /// 是否为 ios
  static bool isIos = Platform.isIOS;

  /// 保存 ios 设备信息
  static IosDeviceInfo iosDeviceInfo;

  // app的上下文
  static BuildContext context;

  /// IOS app 下载地址
  // static String iosDownApkUrl = "https://apps.apple.com/cn/app/qq/id444934666";
  static String iosDownApkUrl =
      "itms-apps://itunes.apple.com/cn/app/id444934666";

  /// 首页 /home.html
  static String h5IpUrl = "http://47.114.153.249/page/";
  static String shareIpUrl = "http://47.114.153.249/share/";
  static String h5DomainUrl = "http://www.geekhelp.cn/page/";

  /// 首页底部Tab的控制器
  static PageController tabController;

  /// 事件控制中心
  static EventBus eventBus;

  /// 接口地址
  static final Map<String, dynamic> ApiUrl = {
    // 接口基地址
    'PhotoBaseUrl': 'https://moehu.net/app',
    // 'PhotoBaseUrl': 'http://192.168.31.100:8090/app',

    // 接口地址
    'ApiList': {
      'login': '/user/Login',
      'reg': '/user/Reg',
      'opusRecommend': '/opus/Recommend',
      'opusOpusInfo': '/opus/OpusInfo',
      'commentAdd': '/comment/add',
      'commentList': '/comment/list',
      'checkUserIsFollow': '/opus/CheckUserIsFollow',
      'opusFollowUser': '/opus/FollowUser',
      'opusCollectionOpus': '/opus/CollectionOpus',
      'opusCheckOpusIsUpvote': '/opus/CheckIsUpvote',
      'opusUpvoteOpus': '/opus/UpvoteOpus',
      'toolUploadFile': '/tool/UploadFile',
      'opusPushOpus': '/opus/PushOpus',
      'opusCheckOpusIsCollection': '/opus/CheckOpusIsCollection',
      'dynamicPersonalDynamic': '/dynamic/PersonalDynamic',
      'dynamicPush': '/dynamic/Push',
      'dynamicTabsDynamic': '/dynamic/TabsDynamic',
      'dynamicDynamicHistory': '/dynamic/DynamicHistory',
      'tagRecommendTag': '/tag/RecommendTag',
      'opusRanking': '/opus/Ranking',
      'opusOpusSearch': '/opus/OpusSearch',
      'dynamicInfo': '/dynamic/Info',
      'OpusTag': '/tag/OpusTag',
      'OpusInfoCreatedTags': '/tag/OpusInfoCreatedTags',
      'UpdateTagsEditStatus': '/tag/UpdateTagsEditStatus',
      'DeleteTag': '/tag/DeleteTag',
      'UserInfo': '/user/UserInfo',
      'CollectionOpusList': '/opus/CollectionOpusList',
      'Follow': '/opus/Follow',
      'getOpusList': '/opus/OpusList',
      'Update': '/tool/Update',
      'FansUserList': '/user/FansUserList',
      'FollowUserList': '/user/FollowUserList'
    }
  };

  static final List<PageViewModel> pages = [
    PageViewModel(
        pageColor: ColorConfig.ThemeColor,
        body: Text(
          '一款专业的插画交流平台',
          style: TextStyle(fontSize: Screen.setFontSize(17.0)),
        ),
        title: Text(
          Config.appName,
          style: TextStyle(fontSize: Screen.setFontSize(30.0)),
        ),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset(
          R.libStaticAndroidTemplate,
          height: Screen.setHeight(225.0),
          width: Screen.setWidth(225.0),
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        body: Text(
          '在这里您可以和更多志趣相投的人进行沟通学习',
          style: TextStyle(fontSize: Screen.setFontSize(17.0)),
        ),
        title: Text(
          '遇见.朋友',
          style: TextStyle(fontSize: Screen.setFontSize(30.0)),
        ),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset(
          R.libStaticImgWelcome2Png,
          height: Screen.setHeight(255.0),
          width: Screen.setWidth(255.0),
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      body: Text(
        '你的热爱在这都必将得到回应',
        style: TextStyle(fontSize: Screen.setFontSize(17.0)),
      ),
      title: Text(
        '付出.得到',
        style: TextStyle(fontSize: Screen.setFontSize(30.0)),
      ),
      mainImage: Image.asset(
        R.libStaticImgWelcome3Png,
        height: Screen.setHeight(255.0),
        width: Screen.setWidth(255.0),
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF607D8B),
      body: Text(
        '点击【进入】开始使用！',
        style: TextStyle(fontSize: Screen.setFontSize(17.0)),
      ),
      title: Text(
        '开始使用',
        style: TextStyle(fontSize: Screen.setFontSize(30.0)),
      ),
      mainImage: Image.asset(
        R.libStaticImgTaxiPng,
        height: Screen.setHeight(255.0),
        width: Screen.setWidth(255.0),
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
  ];
}
