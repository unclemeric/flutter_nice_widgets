import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoSteps extends StatefulWidget {
  final String title;
  const DemoSteps({Key? key, required this.title}) : super(key: key);
  @override
  _DemoSteps createState() => _DemoSteps();
}

class _DemoSteps extends State<DemoSteps> {
  int _active = 1;

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
            title('基本用法'),
            Steps(steps: [
              StepItem('buyer_orders'),
              StepItem('merchant_orders'),
              StepItem('buyer_pick_up'),
              StepItem('transaction_complete'),
            ], active: _active),
            Padding(
                padding: EdgeInsets.all(20),
                child: Wrap(
                  runSpacing: 10,
                  children: <Widget>[
                    NButton(
                      text: '前一个',
                      type: NButtonType.Primary,
                      plain: true,
                      onTap: () {
                        setState(() {
                          _active -= 1;
                          if (_active < 0) _active = 3;
                        });
                      },
                    ),
                    SizedBox(width: 6),
                    NButton(
                      text: '下一个',
                      type: NButtonType.Primary,
                      plain: true,
                      onTap: () {
                        setState(() {
                          _active += 1;
                          if (_active > 3) _active = 0;
                        });
                      },
                    ),
                  ],
                )),
            title('自定义样式'),
            Steps(
              steps: [
                StepItem('buyer_orders'),
                StepItem('merchant_orders'),
                StepItem('buyer_pick_up'),
                StepItem('transaction_complete'),
              ],
              active: _active,
              activeIcon: Icons.done,
              inactiveIcon: Icons.chevron_right,
              activeColor: Colors.green,
            ),
            title('垂直'),
            Steps(
              steps: [
                StepItem('step1', "2016-07-12 12:40"),
                StepItem('step2', "2016-07-12 12:40"),
                StepItem('step3', "2016-07-12 12:40"),
                StepItem('step4', "2016-07-12 12:40")
              ],
              active: _active,
              direction: 'vertical',
            ),
          ],
        ),
      ),
    );
  }
}
