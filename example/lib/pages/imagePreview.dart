import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoImagePreview extends StatefulWidget {
  DemoImagePreview({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DemoImagePreview createState() => _DemoImagePreview();
}

class _DemoImagePreview extends State<DemoImagePreview> {
  List<Widget> images = [
    Image.network("https://img.yzcdn.cn/vant/apple-1.jpg"),
    Image.network("https://img.yzcdn.cn/vant/apple-2.jpg"),
    Image.network("https://img.yzcdn.cn/vant/apple-3.jpg"),
    Image.network("https://img.yzcdn.cn/vant/apple-4.jpg")
  ];

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
            Cell(
              title: 'preview_image',
              isLink: true,
              onClick: () {
                showImagePreview(
                  context: context,
                  images: images,
                );
              },
            ),
            title('incoming_configuration'),
            CellGroup(
              border: false,
              children: [
                Cell(
                  title: 'initial_position',
                  isLink: true,
                  onClick: () {
                    showImagePreview(
                        context: context,
                        images: images,
                        showIndicators: true,
                        startPosition: 2,
                        swipeDuration: Duration(seconds: 2),
                        onChange: (val) {
                          print("Page Changed $val");
                        });
                  },
                ),
                Cell(
                  title: '显示关闭按钮',
                  isLink: true,
                  onClick: () {
                    showImagePreview(
                        context: context, images: images, closeable: true);
                  },
                ),
                Cell(
                  title: '监听关闭事件',
                  isLink: true,
                  onClick: () {
                    showImagePreview(
                        context: context,
                        images: images,
                        closeable: true,
                        onClose: (int index) {
                          print('close_in_image'); // index.toString()
                        });
                  },
                )
              ],
            )
          ])),
    );
  }
}
