import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoField extends StatefulWidget {
  const DemoField({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DemoField createState() => _DemoField();
}

class _DemoField extends State<DemoField> {
  var testInput1 = TextEditingController();
  var testInput2 = TextEditingController(text: "test");
  var testInput3 = TextEditingController();
  var testInput4 = TextEditingController();
  var testInput5 = TextEditingController();
  var testInput6 = TextEditingController();
  var testInput7 = TextEditingController();
  var testInput8 = TextEditingController();
  String mobile = '';

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }

  bool isEmptyName(String text) {
    return text == "";
  }

  bool isErrorPhone(String text) {
    String patttern =
        r'(^([1][3,4,5,6,7,8,9])\d{9}$)'; // 使用 r 前缀，可以创建 “原始 raw” 字符串
    return !(new RegExp(patttern).hasMatch(text));
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
              children: <Widget>[
                Field(
                  placeholder: '请输入用户名',
                  controller: testInput1,
                  onChange: (val) {
                    print("text changed: $val");
                  },
                  onSubmitted: (val) {
                    print("submitted: $val");
                  },
                )
              ],
            ),
            title('自定义'),
            CellGroup(children: <Widget>[
              Field(
                label: '用户名',
                placeholder: '请输入用户名',
                controller: testInput2,
                maxLength: 10,
                clearable: true,
                rightIcon: Icons.help_outline,
                require: true,
                clickRight: () async {
                  print("Click Right!");
                },
              ),
              Field(
                  label: '密码',
                  placeholder: '请输入密码',
                  controller: testInput3,
                  require: true,
                  type: "password"),
            ]),
            title('禁止输入'),
            CellGroup(
              children: <Widget>[
                Field(
                  label: '用户名',
                  placeholder: '禁止输入',
                  disabled: true,
                  controller: testInput4,
                  leftIcon: Icons.perm_identity,
                  clickLeft: () async {
                    print("click left");
                  },
                )
              ],
            ),
            title('错误提示'),
            CellGroup(
              children: <Widget>[
                Field(
                  label: '用户名',
                  placeholder: '请输入用户名',
                  error: isEmptyName(testInput5.text),
                  controller: testInput5,
                  maxLength: 10,
                  clearable: true,
                  onChange: (val) {
                    setState(() {
                      testInput5.text = val;
                      print(val);
                    });
                  },
                ),
                Field(
                  label: '手机号码',
                  placeholder: '请输入与手机号码',
                  controller: testInput6,
                  errorMessage: isErrorPhone(mobile) ? '手机号码错误' : null,
                  maxLength: 11,
                  clearable: true,
                  onChange: (val) {
                    print(isErrorPhone(mobile).toString() + 'PPPPPPPP');
                    setState(() {
                      mobile = val;
                    });
                    // setState(() {
                    //   testInput6.text = val;
                    // });
                  },
                ),
              ],
            ),
            title('插入按钮'),
            CellGroup(
              children: <Widget>[
                Field(
                  label: '验证码',
                  placeholder: '请输入验证码',
                  controller: testInput7,
                  right: NButton(
                    text: '发送验证码',
                    type: NButtonType.Primary,
                    size: NButtonSize.Small,
                    onTap: () => {},
                  ),
                ),
              ],
            ),
            title('显示计数'),
            CellGroup(
              children: <Widget>[
                Field(
                    label: '评论',
                    placeholder: '请输入评论',
                    controller: testInput8,
                    type: "textarea",
                    rows: 5,
                    maxLength: 100,
                    showWordLimit: true),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
