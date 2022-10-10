// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_nice_widgets/flutter_nice_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NWebView extends StatefulWidget {
  final String url;
  final Function(WebViewController webViewController)? onWebViewCreated;
  final Function(int progress, WebViewController webViewController)? onProgress;
  final List<JavascriptChannel>? javascriptChannels;
  final Function(NavigationRequest request)? navigationDelegate;
  final Function(String url)? onPageStarted;
  final Function(String url)? onPageFinished;
  final bool gestureNavigationEnabled;
  const NWebView(
      {Key? key,
      required this.url,
      this.gestureNavigationEnabled: true,
      this.javascriptChannels: const [],
      this.navigationDelegate,
      this.onPageFinished,
      this.onPageStarted,
      this.onProgress,
      this.onWebViewCreated})
      : super(key: key);

  @override
  _NWebViewState createState() => _NWebViewState();
}

class _NWebViewState extends State<NWebView> {
  late WebViewController viewController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String _title = '正在加载...';
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void _getTitleFromPage(WebViewController webViewController) async {
    //   Timer(Duration(seconds: 3), () {
    //   print("3秒后执行");
    // });
    Future.delayed(const Duration(milliseconds: 500), () async {
      String title =
          await webViewController.runJavascriptReturningResult("document.title");
      title = title.replaceAll("\"", ""); // 安卓获取的标题自带双引号需要手动去除，ios没这个问题
      if (title.isNotEmpty) {
        setState(() {
          _title = title;
        });
      } else {
        _getTitleFromPage(webViewController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        leading: NavigationControls(_controller.future),
        actions: <Widget>[
          // SampleMenu(_controller.future),
          // IconButton(onPressed: (){
          //   controller.reload();
          // }, icon: Icon(Icons.refresh)),
          RightControls(_controller.future),
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            viewController = webViewController; // 获取到WebViewController对象给onProgress使用，当页面100%加载完成时往页面传参
            this._getTitleFromPage(webViewController);
            if (widget.onWebViewCreated != null)
              widget.onWebViewCreated!(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
            if (widget.onProgress != null) widget.onProgress!(progress, viewController);
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
            ...widget.javascriptChannels!,
          },

          /// 拦截器
          /// ```javascript
          /// navigationDelegate: (NavigationRequest request) {
          ///   if (request.url.startsWith('https://www.youtube.com/')) {
          ///     print('blocking navigation to $request}');
          ///     return NavigationDecision.prevent;
          ///   }
          ///   print('allowing navigation to $request');
          ///   return NavigationDecision.navigate;
          /// }
          /// ```
          navigationDelegate: (NavigationRequest request) {
            if (widget.navigationDelegate != null) {
              return widget.navigationDelegate!(request);
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            if (widget.onPageStarted != null) widget.onPageStarted!(url);
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            if (widget.onPageFinished != null) widget.onPageFinished!(url);
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
  
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}

class RightControls extends StatelessWidget {
  const RightControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data!;
        return Row(
          children: <Widget>[
            NButton(
              type: NButtonType.Default,
              plain: true,
              text: '刷新',
              textColor: Colors.white,
              hasBorder: false,
              onTap: !webViewReady
                  ? null
                  : () {
                      controller.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture, {super.key});

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        if(!webViewReady) {
          return Container();
        }
        final WebViewController controller = snapshot.data!;
        return Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Platform.isAndroid
                  ? Icons.arrow_back
                  : Icons.arrow_back_ios_new),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      try {
                        if (await controller.canGoBack()) {
                          await controller.goBack();
                        } else {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          return;
                        }
                      } catch (e) {
                        Navigator.pop(context);
                      }
                    },
            ),
            // IconButton(
            //   icon: const Icon(Icons.arrow_forward_ios),
            //   onPressed: !webViewReady
            //       ? null
            //       : () async {
            //           if (await controller.canGoForward()) {
            //             await controller.goForward();
            //           } else {
            //             // ignore: deprecated_member_use
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               const SnackBar(
            //                   content: Text("No forward history item")),
            //             );
            //             return;
            //           }
            //         },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.replay),
            //   onPressed: !webViewReady
            //       ? null
            //       : () {
            //           controller.reload();
            //         },
            // ),
          ],
        );
      },
    );
  }
}
