import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports


void _getTitleFromPage(WebViewController webViewController) async {
  //   Timer(Duration(seconds: 3), () {
  //   print("3秒后执行");
  // });
  Future.delayed(const Duration(milliseconds: 500), () async {
    Object title =
        await webViewController.runJavaScriptReturningResult("document.title");
        print('123');
    // title = title.replaceAll("\"", ""); // 安卓获取的标题自带双引号需要手动去除，ios没这个问题
    // if (title.isNotEmpty) {
    //   setState(() {
    //     _title = title;
    //   });
    // } else {
    //   _getTitleFromPage(webViewController);
    // }
  });
}

WebViewController getWebviewController(String url,
    {void Function(int)? onProgress,
    void Function(String)? onPageStarted,
    void Function(String)? onPageFinished,
    void Function(WebResourceError)? onWebResourceError,
    FutureOr<NavigationDecision> Function(NavigationRequest)?
        onNavigationRequest}) {

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

  WebViewController viewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
          print("WebView is loading (progress : $progress%)");
          if (onProgress != null) onProgress(progress);
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
          if (onPageStarted != null) onPageStarted(url);
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
          if (onPageFinished != null) onPageFinished(url);
        },
        onWebResourceError: (WebResourceError error) {
           debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          if (onWebResourceError != null) onWebResourceError(error);
        },
        onNavigationRequest: (NavigationRequest request) {
          if (onNavigationRequest != null) {
            return onNavigationRequest(request);
          }
          return NavigationDecision.navigate;
          // if (request.url.startsWith('https://www.youtube.com/')) {
          //   return NavigationDecision.prevent;
          // }
          // return NavigationDecision.navigate;
        },
      ),
    )
    // ..addJavaScriptChannel(
    //     'Toaster',
    //     onMessageReceived: (JavaScriptMessage message) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(message.message)),
    //       );
    //     },
    //   )
    ..loadRequest(Uri.parse(url));
    _getTitleFromPage(viewController);
  // #docregion platform_features
  if (controller.platform is AndroidWebViewController) {
    AndroidWebViewController.enableDebugging(true);
    (controller.platform as AndroidWebViewController)
        .setMediaPlaybackRequiresUserGesture(false);
  }
  // #enddocregion platform_features
  return viewController;
}
