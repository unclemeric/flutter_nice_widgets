import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';

class CheckboxPage extends StatelessWidget {
  const CheckboxPage({Key? key, required this.title }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    
    return PageScaffold(
      title: '$title',
      body: SingleChildScrollView(
        child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: [
                NCheckbox(text: '同意',shape: 'square',),
                SizedBox(height: 10.0,),
                CheckboxGroup(
                  inCellGroup: false,
                  values: [],
                  max: 2,
                  shape: 'square',
                  list: [
                    CheckItem(name: '1',text: '🍌'),
                    CheckItem(name: '2',text: '🍐'),
                    CheckItem(name: '0',text: '🍑'),
                  ],
                ),
                SizedBox(height: 10.0,),
                NCheckbox(shape: 'square',),
              ],),
            ),
      ),
      
    );
  }
}