import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';
import 'package:flutter_nice_widgets/utils/take_photo.dart';

class TakePhotoPage extends StatefulWidget {
  final String title;
  const TakePhotoPage({Key? key, required this.title}) : super(key: key);
  @override
  _TakePhotoPage createState() => _TakePhotoPage();
}

class _TakePhotoPage extends State<TakePhotoPage> {
  File? image;
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
            NButton(
              type: NButtonType.Info,
              text: '拍照',
              onTap: () async {
                final img = await TakePhotoUtil.takePhoto();
                if(img ==null) return null;
                this.setState(() {
                  this.image = img as File;
                });
              },
            ),
            SizedBox(height: 10),
            this.image == null
                ? Text('还没拍照')
                : Image.file(this.image!, width: 300, height: 200),
          ],
        ),
      ),
      padding: true,
    );
  }
}
