import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class ActionSheetPage extends StatefulWidget {
  const ActionSheetPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ActionSheetPage createState() => _ActionSheetPage();
}

class _ActionSheetPage extends State<ActionSheetPage> {
  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ActionSheetItem> actionList = [
      ActionSheetItem(name: '选项'),
      ActionSheetItem(name: '选项'),
      ActionSheetItem(
          name: '选项3',
          subname: '基本信息'),
    ];

    List<ActionSheetItem> actionList2 = [
      ActionSheetItem(name: '选项1', color: Colors.green),
      ActionSheetItem(loading: true),
      ActionSheetItem(name:'选项2', disabled: true),
      ActionSheetItem(name: '选项1', color: Colors.green),
      ActionSheetItem(loading: true),
      ActionSheetItem(name:'选项2', disabled: true),
      ActionSheetItem(name: '选项1', color: Colors.green),
      ActionSheetItem(loading: true),
      ActionSheetItem(name:'选项2', disabled: true),
      ActionSheetItem(name: '选项1', color: Colors.green),
      ActionSheetItem(loading: true),
      ActionSheetItem(name:'选项2', disabled: true),
      ActionSheetItem(name: '选项1', color: Colors.green),
      ActionSheetItem(loading: true),
      ActionSheetItem(name:'选项2', disabled: true),
      ActionSheetItem(name: '选项1', color: Colors.green),
      ActionSheetItem(loading: true),
      ActionSheetItem(name:'选项2', disabled: true),
    ];
    return PageScaffold(
      title: '${widget.title}',
      body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title('基础用法'),
          CellGroup(
            border: false,
            children: [
              Cell(
                title: '基础用法',
                isLink: true,
                onClick: () {
                  ActionSheet(
                      actions: actionList,
                      onSelect: (action, index, context) {
                        print(action.name!);
                      }).show(context);
                },
              ),
              Cell(
                title: '显示取消按钮',
                isLink: true,
                onClick: () {
                  ActionSheet(
                    actions: actionList,
                    cancelText: '取消',
                    onCancel: () {
                      print('点击取消');
                    },
                  ).show(context);
                },
              ),
              Cell(
                title: '显示描述',
                isLink: true,
                onClick: () {
                  ActionSheet(
                    actions: actionList,
                    title: '标题',
                    description: '描述',
                  ).show(context);
                },
              ),
            ],
          ),
          title('option选项'),
          Cell(
            title: 'option选项',
            isLink: true,
            onClick: () {
              ActionSheet(actions: actionList2).show(context);
            },
          ),
          title('自定义'),
          Cell(
            title: '自定义',
            isLink: true,
            onClick: () {
              ActionSheet(
                child: Container(
                  height: 150,
                  padding: EdgeInsets.all(10),
                  alignment: AlignmentDirectional.topStart,
                  child: Text("data"),
                ),
                title: '标题',
                closeIcon: Icons.highlight_off,
              ).show(context);
            },
          ),
        ],
      ),
      ),
    );
  }
}
