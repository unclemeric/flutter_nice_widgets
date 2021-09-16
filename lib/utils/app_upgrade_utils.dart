import 'dart:io';

import 'package:dio/dio.dart' show Dio;
import 'package:flutter/material.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart'
    show AppInfo, AppUpgrade, AppUpgradeInfo, DownloadProgressCallback, DownloadStatusChangeCallback, FlutterUpgrade;
import 'package:flutter_nice_widgets/model/AppUpgradeInfo.dart';
import 'package:package_info/package_info.dart';

class AppUpgradeUtils {
  static Future<AppInfo> getAppInfo() async {
      AppInfo appInfo = await FlutterUpgrade.appInfo;
      return appInfo;
    }
  static void checkAppUpgrade(
    BuildContext context,
    String checkUrl, {
    Function(dynamic)? errorCallback,
    String? cancelText = '以后再说',
    String? okText = '马上升级',
    String? iosAppId = '',
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    TextStyle? cancelTextStyle,
    TextStyle? okTextStyle,
    List<Color>? okBackgroundColors,
    Color? progressBarColor,
    double? borderRadius = 20.0,
    // AppMarketInfo? appMarketInfo,
    VoidCallback? onCancel,
    VoidCallback? onOk,
    DownloadProgressCallback? downloadProgress,
    DownloadStatusChangeCallback? downloadStatusChange,
  }) async {
    AppUpgrade.appUpgrade(
      context,
      _checkAppInfo(checkUrl, errorCallback),
      titleStyle: titleStyle,
      contentStyle: contentStyle,
      cancelTextStyle: cancelTextStyle,
      okTextStyle: okTextStyle,
      cancelText: cancelText,
      okText: okText,
      iosAppId: iosAppId,
      onCancel: onCancel,
      onOk: onOk,
      // appMarketInfo:appMarketInfo,
      downloadProgress: downloadProgress,
      downloadStatusChange: downloadStatusChange,
    );
  }

  static Future<AppUpgradeInfo?> _checkAppInfo(
      String checkUrl, Function(dynamic)? errorCallback) async {
    //这里一般访问网络接口，将返回的数据解析成如下格式
    return Dio().get(checkUrl).then((res) async {
      Map<String, dynamic> data = res.data;
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      AppUpdateInfo appUpdateInfo = AppUpdateInfo.fromMap(data);
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      late UpdateInfo updateInfo;
      if (Platform.isIOS) {
        // IOS更新
        updateInfo = appUpdateInfo.ios;
      } else {
        updateInfo = appUpdateInfo.android;
      }
      if (version != updateInfo.version || buildNumber != updateInfo.buildNumber.toString()) {
        return AppUpgradeInfo(
          title: "新版本V${updateInfo.version}",
          apkDownloadUrl: updateInfo.link,
          contents: updateInfo.contents,
          force: false,
        );
      } else {
        return null;
      }
    }).catchError((e) {
      if (errorCallback != null) errorCallback(e);
    });
  }
}
