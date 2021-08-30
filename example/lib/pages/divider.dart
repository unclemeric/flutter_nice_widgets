import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class DividerPage extends StatelessWidget {
  const DividerPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '$title',
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              NDivider(),
              SizedBox(height:10.0),
              NDivider(content: '这是一条有内容的分割线',),
              SizedBox(height:10.0),
              NDivider(content: '这是一条有内容的分割线',fontColor: Colors.red,fontSize: 20.0,),
              SizedBox(height:10.0),
              NDivider(content: '这是一条有内容的分割线',contentPosition:'left'),
              SizedBox(height:10.0),
              NDivider(content: '这是一条有内容的分割线',contentPosition:'right'),
            ],
          ),
        ),
      ),
    );
  }
}
