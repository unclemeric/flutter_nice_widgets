import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoSwipe extends StatefulWidget {
  DemoSwipe({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DemoSwipe createState() => _DemoSwipe();
}

class _DemoSwipe extends State<DemoSwipe> {
  String current = "1";

  @override
  void initState() {
    super.initState();
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 40, 0, 10),
      child: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }

  buildItem(num count) {
    List<Widget> widgets = [];
    for (int i = 1; i <= count; i++) {
      widgets.add(Container(
          color:
              i % 2 == 0 ? Colors.lightBlue : Colors.lightBlue.withOpacity(.8),
          child: Center(
              child: Text(i.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.white)))));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '${widget.title}',
      body: ListView(children: <Widget>[
        title('基础用法'),
        Container(
            height: 220.0,
            child: Swipe(
              autoPlay: true,
              children: <Widget>[
                Image.network("https://img.yzcdn.cn/vant/apple-1.jpg"),
                Image.network("https://img.yzcdn.cn/vant/apple-2.jpg"),
                Image.network("https://img.yzcdn.cn/vant/apple-3.jpg"),
                Image.network("https://img.yzcdn.cn/vant/apple-4.jpg")
              ],
            )),
        title('监听change事件'),
        Container(
            height: 220.0,
            child: Swipe(
              autoPlay: true,
              indicatorColor: Colors.white,
              children: buildItem(4),
              // onChange: (val) {
              //   Utils.toast(val);
              // },
            )),
        title('垂直滚动'),
        Container(
            height: 220.0,
            child: Swipe(
              autoPlay: true,
              scrollDirection: 'vertical',
              indicatorColor: Colors.white,
              children: buildItem(4),
            )),
        title('自定义动画'),
        Container(
            height: 220.0,
            child: Swipe(
              autoPlay: true,
              indicatorColor: Colors.redAccent,
              indicatorSize: 12.0,
              interval: Duration(seconds: 5),
              duration: Duration(seconds: 3),
              children: buildItem(4),
            )),
        title('设置滑动属性'),
        Container(
            height: 220.0,
            child: Swipe(
              autoPlay: true,
              viewportFraction: .5,
              children: <Widget>[
                Image.network("https://img.yzcdn.cn/vant/apple-1.jpg"),
                Image.network("https://img.yzcdn.cn/vant/apple-2.jpg"),
                Image.network("https://img.yzcdn.cn/vant/apple-3.jpg"),
                Image.network("https://img.yzcdn.cn/vant/apple-4.jpg")
              ],
            )),
        title('自定义指针'),
        Container(
            height: 220.0,
            child: Swipe(
              autoPlay: true,
              children: buildItem(4),
              showIndicators: true,
              onChange: (val) {
                setState(() {
                  current = val.toString();
                });
              },
              indicator: Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  // width: 20,
                  // height: 20,
                  padding: EdgeInsets.all(5),
                  color: Colors.black.withOpacity(.2),
                  child: Text("$current/4",
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
            )),
      ]),
    );
  }
}
