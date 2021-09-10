import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';
import 'package:flutter_nice_widgets/model/ContactInfo.dart';

class NConcatPage extends StatefulWidget {
  const NConcatPage({Key? key}) : super(key: key);

  @override
  _NConcatPageState createState() => _NConcatPageState();
}

class _NConcatPageState extends State<NConcatPage> {
  ContactInfo? contactInfo;
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: '通讯录',
      padding: true,
      body: Container(
        child: Column(
          children: [
            NButton(
              type: NButtonType.Primary,
              text: '打开通讯录',
              onTap: () async {
                contactInfo = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return NConcats();
                }));
                setState(() {});
              },
            ),
            SizedBox(height:10),
            Text(contactInfo == null ? '未选择通讯录' : '您选择的通讯录\n姓名是： ${contactInfo!.name},\n号码为：${contactInfo!.phone}')
          ],
        ),
      ),
    );
  }
}
