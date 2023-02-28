import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class NumberKeyboardPage extends StatefulWidget {
  const NumberKeyboardPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _NumberKeyboardPageState createState() => _NumberKeyboardPageState();
}

class _NumberKeyboardPageState extends State<NumberKeyboardPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController(text: '');
    return PageScaffold(
      title: '${widget.title}',
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text('基础用法'),
              Builder(builder: (context) {
                return NButton(
                  text: '默认键盘',
                  type: NButtonType.Primary,
                  onTap: () {
                    NumberKeyboard(
                        value: controller.text,
                        title: '默认键盘',
                        closeButtomText: '完成',
                        extraKey: ".",
                        onChange: (String val) {
                          controller.text = val;
                        }).show(context);
                  },
                );
              }),
              Text('基础用法'),
              Builder(builder: (context) {
                return Field(
                  placeholder: '请输入',
                  controller: controller,
                  readonly: true,
                  onClick: () {
                    NumberKeyboard(
                        value: controller.text,
                        maxlength: 6,
                        closeButtomText: '完成',
                        extraKey: ".",
                        onChange: (String val) {
                          controller.text = val;
                        }).show(context);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
