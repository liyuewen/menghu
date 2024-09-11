import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_update_dialog/update_dialog.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peach/R.dart';
import 'package:peach/config/_.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/http/Dio.dart';
import 'package:peach/service/_.dart';
import 'package:peach/utils/_.dart';

/*
 * 检测新版本
 */
class CheckUpdate {
  // 保存升级弹窗
  UpdateDialog _dialog;
  double _progress = 0.0;
  bool force; // false 不强制升级  true 强制升级
  File _apkFile;

  Future<bool> check(BuildContext context) async {
    // 检查版本
    Data res = await PublicService.update(params: {});
    if (res.updateForce == 0) {
      force = false;
    } else {
      force = true;
    }
    // 如果需要升级
    if (int.parse(Config.packageInfo.buildNumber) < res.updateVersionCode) {
      if (_dialog != null && _dialog.isShowing()) {
        return false;
      }

      // 显示弹窗
      _dialog = UpdateDialog.showUpdate(context,
          title: "发现新版本 v${res.updateVersion}，请升级！",
          updateContent: res.updateContent,
          width: Screen.setWidth(280),
          topImage: Image.asset(R.libStaticImgUpdateBgAppTopPng),
          themeColor: ColorConfig.ThemeColor,
          updateButtonText: '升级到最新版',
          ignoreButtonText: '忽略',
          enableIgnore: !force, // true 可以忽略，不强制升级
          onIgnore: () {
            _dialog.dismiss();
          },
          isForce: force, // false 显示关闭按钮 不强制升级
          onUpdate: () async {
            // 如果是android 那么下载app
            if (Config.isAndroid) {
              print("如果是android 那么下载app");
              // 获取临时下载地址
              _apkFile = await getApkFileByUpdateEntity(res);
              await onUpdate(res);
              // 如果是ios 那么打开appstore
            } else {
              InstallPlugin.gotoAppStore(Config.iosDownApkUrl);
            }
          }
      );
      return true;
    } else {
      return false;
    }
  }

  // 下载文件，更新进度条
  Future<void> onUpdate(Data res) async {
    await HttpApi().downloadFile(
        res.updateDownUrl, _apkFile.path,
        onReceiveProgress: (int count, int total) {
          _progress = count.toDouble() / total;
          if (_progress <= 1.0001) {
            _dialog.update(_progress);
          }
        }).then((value) {
      _dialog.dismiss();
      installAPP();
    }).catchError((value) {
      _dialog.dismiss();
    });
  }

  /// android 安装app
  void installAPP() async {
    String packageName = Config.packageInfo.packageName;
    InstallPlugin.installApk(_apkFile.path, packageName);
  }

  /// 根据更新信息获取apk安装文件
  Future<File> getApkFileByUpdateEntity(Data res) async {
    // 获取app文件名
    String appName = getApkNameByDownloadUrl(res.updateDownUrl);
    // 获取下载的缓存路径
    String dirPath = await getDownloadDirPath();
    return File("$dirPath/${res.updateVersion}/$appName");
  }

  ///获取下载缓存路径
  Future<String> getDownloadDirPath() async {
    Directory directory = Config.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  ///根据下载地址获取文件名
  String getApkNameByDownloadUrl(String downloadUrl) {
    if (downloadUrl.isEmpty) {
      return "temp_${currentTimeMillis()}.apk";
    } else {
      String appName = downloadUrl.substring(downloadUrl.lastIndexOf("/") + 1);
      if (!appName.endsWith(".apk")) {
        appName = "temp_${currentTimeMillis()}.apk";
      }
      return appName;
    }
  }

  /// 返回随机文件名
  int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
