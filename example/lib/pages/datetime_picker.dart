import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';
import 'package:flutter_nice_widgets/utils/datetime_picker.dart';

class DatetimePickerPage extends StatefulWidget {
  final String title;
  const DatetimePickerPage({Key? key, required this.title}) : super(key: key);
  @override
  _DatetimePickerPage createState() => _DatetimePickerPage();
}

class _DatetimePickerPage extends State<DatetimePickerPage> {
  String date1 = '';
  String date2 = '';
  String date3 = '';
  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
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
            Row(
              children: [
                NButton(
                  type: NButtonType.Info,
                  text: '时分秒显示',
                  onTap: () async {
                    DateTimePickerUtil.showTimePicker(context,
                        onConfirm: (DateTime date) {
                          print(DateTime.fromMillisecondsSinceEpoch(
                                date.millisecondsSinceEpoch));
                      this.setState(() {
                        date1 = DateTime.fromMillisecondsSinceEpoch(
                                date.millisecondsSinceEpoch)
                            .toString().substring(10,19);
                      });
                    });
                  },
                ),
                SizedBox(width: 20),
                Text('$date1'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                NButton(
                  type: NButtonType.Info,
                  text: '中文年月日显示',
                  onTap: () async {
                    DateTimePickerUtil.showDatePicker(context,
                        onConfirm: (DateTime date) {
                      this.setState(() {
                        date2 = DateTime.fromMillisecondsSinceEpoch(
                                date.millisecondsSinceEpoch)
                            .toString().substring(0,19);
                      });
                    });
                  },
                ),
                SizedBox(width: 20),
                Text('$date2'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                NButton(
                  type: NButtonType.Info,
                  text: '中文年月日显示',
                  onTap: () async {
                    DateTimePickerUtil.showTime12hPicker(context,
                        onConfirm: (DateTime date) {
                      this.setState(() {
                        date3 = DateTime.fromMillisecondsSinceEpoch(
                                date.millisecondsSinceEpoch)
                            .toString().substring(0,19);
                      });
                    });
                  },
                ),
                SizedBox(width: 20),
                Text('$date3'),
              ],
            ),
          ],
        ),
      ),
      padding: true,
    );
  }
}
