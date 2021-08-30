import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoDialog extends StatefulWidget {
  const DemoDialog({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DemoDialog createState() => _DemoDialog();
}

class _DemoDialog extends State<DemoDialog> {
  void _showDialog1(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: '标题',
          message: '示例内容',
        );
      },
    );
  }

  void _showDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          message: '示例内容',
        );
      },
    );
  }

  void _showDialog3(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: '标题',
          message: '示例内容',
          showCancelButton: true,
        );
      },
    );
  }

  void _showDialog4(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: '标题',
          message: '示例内容',
          showCancelButton: true,
          confirmButtonColor: Colors.blueAccent,
          confirmTextColor: Colors.white,
          confirmButtonText: "确定",
          cancelButtonColor: Colors.red,
          cancelTextColor: Colors.white,
          cancelButtonText: "取消",
          titleAlign: AlignmentDirectional.centerStart,
          messageAlign: TextAlign.start,
        );
      },
    );
  }

  void _showDialog5(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: '标题',
          message: '示例内容',
          showCancelButton: true,
          beforeClose: () {
            return Future.delayed(Duration(seconds: 1), () {
              return true;
            });
          },
        );
      },
    );
  }

  void _showDialog6(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return NDialog(
          title: '标题',
          child: Container(
            padding: EdgeInsets.all(24),
            child: Image.network("https://img.yzcdn.cn/vant/apple-1.jpg"),
          ),
          showCancelButton: true,
          beforeClose: () {
            return Future.delayed(
                Duration(seconds: 1), () {} as FutureOr<bool> Function()?);
          },
        );
      },
    );
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '${widget.title}',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title('基础用法'),
            CellGroup(
              children: [
                Cell(
                  title: '提示',
                  isLink: true,
                  onClick: () {
                    _showDialog1(context);
                  },
                ),
                Cell(
                  title: '无标题对话框',
                  isLink: true,
                  onClick: () {
                    _showDialog2(context);
                  },
                ),
                Cell(
                  title: '确认对话框',
                  isLink: true,
                  onClick: () {
                    _showDialog3(context);
                  },
                ),
              ],
            ),
            title('同步调用'),
            Cell(
              title: '同步调用',
              isLink: true,
              onClick: () {
                _showDialog5(context);
              },
            ),
            title('自定义确认对话框'),
            Cell(
              title: '自定义确认对话框',
              isLink: true,
              onClick: () {
                _showDialog4(context);
              },
            ),
            title('自定义内容对话框'),
            Cell(
              title: '自定义内容',
              isLink: true,
              onClick: () {
                _showDialog6(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
