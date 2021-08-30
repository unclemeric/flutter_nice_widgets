import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class CellPage extends StatelessWidget {
  const CellPage({Key? key, required this.title}) : super(key: key);
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
              CellGroup(children: <Widget>[
                Cell(
                  title: '姓名',
                  value: 'laisanfa',
                  isLink: true,
                ),
                Cell(
                  icon: Icons.ac_unit,
                  title: '姓名',
                  value: 'laisanfa',
                  isLink: true,
                  require: true,
                ),
              ]),
              Cell(
                  title: '姓名',
                  value: 'laisanfa',
                  isLink: true,
                  clickable: true,
                  onClick: () => {print('点击')}),
              NDivider(),
              Cell(
                customTitle: Row(
                  children: [Icon(Icons.face), Text('大脸猫多少岁？')],
                ),
                value: '答案：10岁',
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
