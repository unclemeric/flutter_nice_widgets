import 'package:flutter/material.dart';

class EmptyText extends StatelessWidget {
  final String? title;
  EmptyText({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Text(this.title ?? '数据为空', style: TextStyle(fontSize: 15.0),),
    );
  }
}