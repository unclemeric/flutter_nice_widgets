import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoPasswordInput extends StatefulWidget {
  DemoPasswordInput({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DemoPasswordInput createState() => _DemoPasswordInput();
}

class _DemoPasswordInput extends State<DemoPasswordInput> {
  String _value = "123";

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
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
          PasswordInput(
            value: _value,
            info: '密码提示',
            onSubmitted: (val) {
              print("onSubmitted $val");
            },
          ),
          title('自定义长度'),
          PasswordInput(
              value: "1234", info: '验证码', length: 4),
          title('清除内容'),
          PasswordInput(
            value: "12",
            mask: false,
          )
        ],
      )),
    );
  }
}
