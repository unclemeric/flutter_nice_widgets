import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoStepper extends StatefulWidget {
  final String title;
  const DemoStepper({Key? key, required this.title}) : super(key: key);
  @override
  _DemoStepper createState() => _DemoStepper();
}

class _DemoStepper extends State<DemoStepper> {
  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
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
          CellGroup(
            children: <Widget>[
              Cell(
                title: '基本用法',
                customRight: Steppers(
                  onChange: (val) {
                    print(val);
                  },
                ),
              ),
              Cell(
                title: '设置步进2',
                customRight: Steppers(
                  step: 2,
                  onChange: (val) {
                    print(val);
                  },
                ),
              ),
              Cell(
                title: '设置大小区间',
                customRight: Steppers(
                  value: 5,
                  min: 5,
                  max: 10,
                  onChange: (val) {
                    print(val);
                  },
                ),
              ),
              Cell(
                title: '禁止步进',
                customRight: Steppers(value: 1, disabled: true),
              ),
              Cell(
                title: '禁止输入',
                customRight: Steppers(
                  value: 1,
                  disabledInput: true,
                  onChange: (val) {},
                ),
              ),
              Cell(
                title: '小数点精度',
                customRight: Steppers(
                  value: 1,
                  step: 0.2,
                  decimalLength: 2,
                  inputWidth: 46,
                  onChange: (val) {},
                ),
              ),
              Cell(
                title: '自定义步进',
                customRight: Steppers(
                  value: 1,
                  size: 28,
                  inputWidth: 100,
                  onChange: (val) {},
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
    );
  }
}
