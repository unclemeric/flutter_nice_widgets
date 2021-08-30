import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, required this.title }) : super(key: key);
  final String title;
  @override
  _LoadingPage createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              title('基本用法'),
              Loading(),
              title('自定义颜色'),
              Loading(
                color: Colors.redAccent,
              ),
              title('加载文字'),
              Loading(
                color: Colors.blueAccent,
                text: '加载中',
              ),
              title('垂直'),
              Loading(
                color: Colors.blueAccent,
                text: '加载中',
                size: 20,
                vertical: true,
              ),
              title('自定义'),
              Container(
                width: 100,
                child: Loading(
                  loading: Image.network(
                      "https://loading.io/mod/spinner/lava-lamp/sample.gif"),
                  text: '加载中',
                ),
              ),
              title('显示加载弹窗'),
              NButton(
                text: '显示加载中',
                type: NButtonType.Primary,
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.white),
                            padding: EdgeInsets.all(20),
                            child: Loading(
                              color: Colors.blueAccent,
                              text: '加载中',
                            ),
                          ),
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
