import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  PageScaffold({this.title, this.body, this.padding: false, this.bottomNavigationBar});

  final String? title;
  final Widget? body;
  final bool padding;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(padding ? 16.0 : 0),
            decoration: BoxDecoration(
              color: Color(0xfff7f8fa),
            ),
            child: body),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
