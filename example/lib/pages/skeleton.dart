import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';
import 'package:flutter_nice_widgets/widgets/scaffold.dart';

class DemoSkeleton extends StatefulWidget {
  final String title;
  const DemoSkeleton({Key? key, required this.title}) : super(key: key);
  @override
  _DemoSkeleton createState() => _DemoSkeleton();
}

class _DemoSkeleton extends State<DemoSkeleton> {
  bool _loading = true;

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
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
            Skeleton(
              row: 3,
              title: true,
            ),
            Skeleton(
              row: 3,
              title: true,
              avatar: true,
              avatarShape: "round",
            ),
            CupertinoSwitch(
              value: _loading,
              onChanged: (value) {
                setState(() {
                  _loading = value;
                });
              },
            ),
            SizedBox(height: 6),
            Skeleton(
              row: 3,
              title: true,
              avatarShape: "round",
              loading: !_loading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('关于vant',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('骨架', style: TextStyle(fontSize: 14, height: 1.5))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
