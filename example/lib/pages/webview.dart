import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/utils/take_photo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_nice_widgets/widgets/webveiw.dart';

class WebviewPage extends StatelessWidget {
  const WebviewPage({ Key? key }) : super(key: key);


  JavascriptChannel _takePhotoJavascriptChannel(BuildContext context) {
      return JavascriptChannel(
        name: 'TakePhoto',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
          TakePhotoUtil.takePhoto();
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    return NWebView(url: 'https://www.baidu.com/',
      onWebViewCreated: (WebViewController webViewController){
        // when webview created do something
      },
      onProgress: (progress, viewController){
        if(progress == 100){
          String script = 'window.isLogin="yes";window.getInfo("是否登录")';
          viewController.runJavascriptReturningResult(script).then((result){
            print(result.toString()); // 接收script中window.getInfo返回值
          });
        }
      },
      javascriptChannels: [
        _takePhotoJavascriptChannel(context),
      ],);
  }
}

// vue与webview交互代码
// mounted() {
//  //直接使用webview传入值需要加timeout延迟去接收值，以免获取不到
//   setTimeout(() => {
//     alert(window.isLogin)
//   }, 500)
//   window.getInfo = function(val) {
//     Toaster.postMessage(val)
//     return '0000'
//   }
// },
// methods: {
//   takePic() {
//     TakePhoto.postMessage('aaa')
//   },
// },