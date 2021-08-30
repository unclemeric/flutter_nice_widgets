import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class RadioPage extends StatelessWidget {
  const RadioPage({Key? key, required this.title }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    
    return PageScaffold(
      title: '$title',
      body: SingleChildScrollView(
        child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: [
                NCheckbox(name: '同意',text: '同意',),
                SizedBox(height: 10.0,),
                RadioGroup(
                  inCellGroup: false,
                  value: '1',
                  list: [
                    RadioItem(name: '1',text: '🍌'),
                    RadioItem(name: '2',text: '🍐'),
                    RadioItem(name: '0',text: '🍑'),
                  ],
                ),
                SizedBox(height: 10.0,),
                NCheckbox(name: 'true'),
              ],),
            ),
      ),
      
    );
  }
}