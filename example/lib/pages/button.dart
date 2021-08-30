import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoButton extends StatefulWidget {
  const DemoButton({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DemoButton createState() => _DemoButton();
}

class _DemoButton extends State<DemoButton> {
  bool _loading = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

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
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title('default_button'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  NButton(
                    text: 'default_button',
                    type: NButtonType.Default,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'primary_button',
                    type: NButtonType.Primary,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'info_button',
                    type: NButtonType.Info,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'danger_button',
                    type: NButtonType.Danger,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'warning_button',
                    type: NButtonType.Warning,
                    onTap: () {},
                  ),
                ],
              ),
              title('plain_button'),
              Wrap(
                spacing: 12,
                children: <Widget>[
                  NButton(
                    plain: true,
                    text: 'plain_button',
                    type: NButtonType.Primary,
                    onTap: () {},
                  ),
                  NButton(
                    plain: true,
                    text: 'plain_button',
                    type: NButtonType.Info,
                    onTap: () {},
                  )
                ],
              ),
              title('hairline_button'),
              Wrap(
                spacing: 12,
                children: <Widget>[
                  NButton(
                    plain: true,
                    hairline: true,
                    text: 'hairline_button',
                    type: NButtonType.Primary,
                    onTap: () {},
                  ),
                  NButton(
                    plain: true,
                    hairline: true,
                    text: 'hairline_button',
                    type: NButtonType.Info,
                    onTap: () {},
                  )
                ],
              ),
              title('disabled_button'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  NButton(
                    disabled: true,
                    text: 'disabled_button',
                  ),
                  NButton(
                    disabled: true,
                    text: 'disabled_button',
                    type: NButtonType.Primary,
                  ),
                  NButton(
                    plain: true,
                    disabled: true,
                    text: 'disabled_button',
                    type: NButtonType.Info,
                  )
                ],
              ),
              title('loading_status'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  NButton(
                    loading: true,
                    type: NButtonType.Primary,
                  ),
                  NButton(
                    loading: true,
                    text: 'loading',
                    type: NButtonType.Primary,
                  ),
                  NButton(
                    plain: true,
                    loading: _loading,
                    text: 'click_after_2_second',
                    type: NButtonType.Info,
                    onTap: () {
                      setState(() {
                        _loading = true;
                      });
                      int count = 2;
                      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                        setState(() {
                          if (count < 1) {
                            _timer.cancel();
                            _loading = false;
                          } else {
                            count -= 1;
                          }
                        });
                      });
                    },
                  )
                ],
              ),
              title('button_shape'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  NButton(
                    text: 'square_button',
                    type: NButtonType.Primary,
                    square: true,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'round_button',
                    type: NButtonType.Info,
                    round: true,
                    onTap: () {},
                  ),
                  NButton(
                    plain: true,
                    text: 'round_button',
                    type: NButtonType.Primary,
                    round: true,
                    onTap: () {},
                  ),
                  NButton(
                    block: true,
                    text: 'block_button',
                    type: NButtonType.Info,
                    onTap: () {},
                  )
                ],
              ),
              title('icon'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  NButton(
                    icon:
                        Icon(Icons.star_border, color: Colors.white, size: 18),
                    type: NButtonType.Primary,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'button',
                    icon:
                        Icon(Icons.star_border, color: Colors.white, size: 18),
                    type: NButtonType.Primary,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'button',
                    plain: true,
                    icon: SizedBox(
                      width: 18,
                      child:
                          Image.network("https://img.yzcdn.cn/vant/logo.png"),
                    ),
                    type: NButtonType.Primary,
                    onTap: () {},
                  )
                ],
              ),
              title('button_size'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  NButton(
                    type: NButtonType.Primary,
                    size: NButtonSize.Large,
                    text: 'large_button',
                    onTap: () {},
                  ),
                  NButton(
                    type: NButtonType.Primary,
                    size: NButtonSize.Normal,
                    text: 'normal_button',
                    onTap: () {},
                  ),
                  NButton(
                    type: NButtonType.Primary,
                    size: NButtonSize.Small,
                    text: 'small_button',
                    onTap: () {},
                  ),
                  NButton(
                    type: NButtonType.Primary,
                    size: NButtonSize.Mini,
                    text: 'mini_button',
                    onTap: () {},
                  ),
                ],
              ),
              title('custom_color'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  NButton(
                    text: 'pure_button',
                    color: Colors.purple,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'pure_button',
                    color: Colors.purple,
                    plain: true,
                    onTap: () {},
                  ),
                  NButton(
                    text: 'gradient_button',
                    color: LinearGradient(
                        colors: [Colors.lightBlue[300]!, Colors.blueAccent]),
                    onTap: () {},
                  ),
                  NButton(
                    text: 'gradient_button',
                    color: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.greenAccent, Colors.redAccent]),
                    onTap: () {},
                  ),
                  NButton(
                    text: 'gradient_button',
                    color: RadialGradient(
                        radius: 2,
                        colors: [Colors.lightBlue[300]!, Colors.blueAccent]),
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 20)
            ],
          )),
      padding: true,
      bottomNavigationBar: NButton(
        text: '按钮',
        size: NButtonSize.Large,
        type: NButtonType.Primary,
        height: 48,
        onTap: () {
          debugPrint('21312231');
        },
      ),
    );
  }
}
