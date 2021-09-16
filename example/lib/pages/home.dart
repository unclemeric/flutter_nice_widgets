import 'actionSheet.dart';
import 'app_upgrade.dart';
import 'checkbox.dart';
import 'button.dart';
import 'conctact.dart';
import 'datetime_picker.dart';
import 'imagePreview.dart';
import 'passwordInput.dart';
import 'search.dart';
import 'swipe.dart';
import 'tag.dart';
import 'dialog.dart';
import 'loading.dart';
import 'skeleton.dart';
import 'n-stepper.dart';
import 'steps.dart';
import 'divider.dart';
import 'radio.dart';
import 'take_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

import 'avatar.dart';
import 'cell.dart';
import 'image.dart';
import 'field.dart';
import 'numberKeyboard.dart';

class MenuItem {
  String name;
  Widget page;
  MenuItem(this.name,this.page);
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MenuItem> items = [
      MenuItem("App更新", AppUpgradePage()),
      MenuItem("webview", NWebView(url: 'https://www.hwagain.cn/hwagain/apk/html-test/#/supplierRegistration'),),
      MenuItem("通讯录", NConcatPage()),
      MenuItem("按钮", DemoButton(title: '按钮',),),
      MenuItem("复选框", CheckboxPage(title: '复选框',),),
      MenuItem("单选框", RadioPage(title: '单选框',),),
      MenuItem("单元行", CellPage(title: '单元行',),),
      MenuItem("分割线", DividerPage(title: '分割线',),),
      MenuItem("输入框", DemoField(title: '输入框',),),
      MenuItem("数字键盘", NumberKeyBoardPage(title: '数字键盘',),),
      MenuItem("选项弹窗", ActionSheetPage(title: '选项弹窗',),),
      MenuItem("头像", AvatarPage(title: '头像',),),
      MenuItem("骨架", DemoSkeleton(title: '骨架',),),
      MenuItem("步进器", DemoSteps(title: '步进器',),),
      MenuItem("步进", DemoStepper(title: '步进',),),
      MenuItem("加载", LoadingPage(title: '加载',),),
      MenuItem("对话框", DemoDialog(title: '对话框',),),
      MenuItem("图片", DemoImage(title: '图片',),),
      MenuItem("轮播图", DemoSwipe(title: '轮播图',),),
      MenuItem("图片预览", DemoImagePreview(title: '图片预览',),),
      MenuItem("标签", DemoTag(title: '标签',),),
      MenuItem("搜索栏", DemoSearch(title: '搜索栏',),),
      MenuItem("密码键盘", DemoPasswordInput(title: '密码键盘',),),
      MenuItem("拍照", TakePhotoPage(title: '拍照',),),
      MenuItem("日期时间", DatetimePickerPage(title: '日期时间',),),
    ];
    return PageScaffold(
      title: '例子',
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (BuildContext build, int i) {
            return Divider();
          },
          itemBuilder: (BuildContext build, int i) {
            return ListTile(
              title: Text(items[i].name),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return items[i].page;
                })),
              },
            );
          },
        ),
      ),
    );
  }
}
