import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';
import 'package:flutter_nice_widgets/utils/app_upgrade_utils.dart';

class AppUpgradePage extends StatelessWidget {
  const AppUpgradePage({ Key? key }) : super(key: key);

  getVersion()async {
    var info = await AppUpgradeUtils.getAppInfo();
    print(info.packageName);
    print(info.versionCode);
    print(info.versionName);
  }

  @override
  Widget build(BuildContext context) {
    this.getVersion();
    AppUpgradeUtils.checkAppUpgrade(context, 'https://www.hwagain.cn/hwagain/apk/app/vehicle_transportation_apk/version.json',downloadProgress: (i,p){
      print(i.toString());
      print(p.toString());

    },onCancel: (){
      print('取消了');
    },errorCallback: (e){
      log(e.toString());
    });
    return PageScaffold(
      padding: true,
      title: 'APP检查更新',
      body: Container(child: Text('APP检查更新'),),
    );
  }
}