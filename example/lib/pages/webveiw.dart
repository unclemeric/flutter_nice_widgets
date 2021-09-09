// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';
import 'package:example/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;
  final Function(WebViewController webViewController)? onWebViewCreated;
  final Function(int progress)? onProgress;
  final List<JavascriptChannel>? javascriptChannels;
  final Function(NavigationRequest request)? navigationDelegate;
  final Function(String url)? onPageStarted;
  final Function(String url)? onPageFinished;
  final bool gestureNavigationEnabled;
  const WebViewExample(
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
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String _title = '';
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
          await webViewController.evaluateJavascript("document.title");
      if (title.length > 2) {
        this.setState(() {
          this._title = title.substring(1, title.length - 1);
        });
      } else {
        this._getTitleFromPage(webViewController);
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
          SampleMenu(_controller.future),
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            this._getTitleFromPage(webViewController);
            if (widget.onWebViewCreated != null)
              widget.onWebViewCreated!(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
            if (widget.onProgress != null) widget.onProgress!(progress);
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
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}

enum MenuOptions {
  clearCookies,
  clearCache,
  navigationDelegate,
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller);

  final Future<WebViewController> controller;
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.clearCookies:
                WebviewUtils.clearCookies(context);
                break;
              case MenuOptions.clearCache:
                WebviewUtils.clearCache(controller.data!, context);
                break;
              case MenuOptions.navigationDelegate:
                WebviewUtils.webviewNavigationDelegate(controller.data!, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCookies,
              child: Text('清除cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCache,
              child: Text('清除缓存'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.navigationDelegate,
              child: Text('导航代理'),
            ),
          ],
        );
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

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
            IconButton(
              icon: Icon(Platform.isAndroid
                  ? Icons.arrow_back
                  : Icons.arrow_back_ios_new),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        return;
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
            //             Scaffold.of(context).showSnackBar(
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
