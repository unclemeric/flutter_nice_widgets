import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DemoTag extends StatefulWidget {
  DemoTag({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DemoTag createState() => _DemoTag();
}

class _DemoTag extends State<DemoTag> {
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
          CellGroup(border: false, children: <Widget>[
            Cell(
                title: '默认类型',
                customRight: Tag(text: '标签'),),
            Cell(
                title: 'primary',
                customRight: Tag(type: "primary", text: '标签')),
            Cell(
                title: 'success',
                customRight: Tag(type: "success", text: '标签')),
            Cell(
                title: 'danger',
                customRight: Tag(type: "danger", text: '标签')),
            Cell(
                title: 'warning',
                customRight: Tag(type: "warning", text: '标签')),
          ]),
          title('样式'),
          CellGroup(border: false, children: <Widget>[
            Cell(
                title: 'plain_style',
                customRight: Tag(
                    type: "primary", text: '标签', plain: true)),
            Cell(
                title: 'round_style',
                customRight: Tag(
                    type: "primary", text: '标签', round: true)),
            Cell(
                title: 'mark_style',
                customRight: Tag(
                    type: "primary", text: '标签', mark: true)),
            Cell(
                title: 'closeable_tag',
                customRight: Tag(
                  type: "primary",
                  text: '标签',
                  onClose: () async {
                    print("close");
                  },
                )),
          ]),
          title('标签大小'),
          CellGroup(border: false, children: <Widget>[
            Cell(
                title: 'small_tag',
                customRight: Tag(type: "primary", text: '标签')),
            Cell(
                title: 'medium_tag',
                customRight: Tag(
                    type: "primary",
                    text: '标签',
                    size: "medium")),
            Cell(
                title: 'large_tag',
                customRight: Tag(
                    type: "primary", text: '标签', size: "large"))
          ]),
          title('自定义颜色'),
          CellGroup(border: false, children: <Widget>[
            Cell(
                title: 'background_color',
                customRight: Tag(
                    type: "primary",
                    text: '标签',
                    color: Colors.purple)),
            Cell(
                title: 'font_color',
                customRight: Tag(
                    type: "primary",
                    text: '标签',
                    color: Colors.red[100],
                    textColor: Colors.red[600])),
            Cell(
                title: 'plain_color',
                customRight: Tag(
                    type: "primary",
                    text: '标签',
                    plain: true,
                    color: Colors.purple))
          ]),
        ],
      )),
    );
  }
}
