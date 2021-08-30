import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _AvatarPage createState() => _AvatarPage();
}

class _AvatarPage extends State<AvatarPage> {
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            title('圆型'),
            Wrap(
              spacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Avatar(type: 'large'),
                Avatar(),
                Avatar(type: 'small'),
              ],
            ),
            title('圆角方形'),
            Wrap(
              spacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Avatar(type: 'large', shape: "square"),
                Avatar(shape: "square"),
                Avatar(type: 'small', shape: "square"),
              ],
            ),
            title('图标颜色'),
            Avatar(color: Colors.blueAccent, iconColor: Colors.white),
            title('自定义'),
            Wrap(
              spacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Avatar(
                  custom: Text("U"),
                ),
                Avatar(image: NetworkImage("https://img.yzcdn.cn/vant/cat.jpeg")),
                Avatar(
                  custom: Image.network(
                      "http://img10.360buyimg.com/uba/jfs/t1/69001/30/2126/550/5d06f947Effd02898/95f18e668670e598.png",
                      width: 20),
                ),
              ],
            ),
            title('点击事件'),
            Avatar(
              onClick: () {
                print('头像点击');
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}
