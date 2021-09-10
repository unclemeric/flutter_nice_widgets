import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewUtils {
  static final CookieManager cookieManager = CookieManager();
  static const String navigationPage = '''
    <!DOCTYPE html><html>
    <head><title>Navigation Delegate Example</title></head>
    <body>
    <p>
    导航代理设置为阻止对youtube网站的导航.
    </p>
    <ul>
    <ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
    <ul><a href="https://www.google.cn/">https://www.google.cn/</a></ul>
    </ul>
    </body>
    </html>
    ''';

  static Future<String> convertHtmlToBase64(
      BuildContext context, String htmlStr) async {
    String contentBase64 = base64Encode(const Utf8Encoder().convert(htmlStr));
    return contentBase64;
  }

  static Future<String> showUserAgent(
      WebViewController controller, BuildContext context) async {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    String userAgent = await controller.evaluateJavascript(
        'Toaster.postMessage("User Agent: " + navigator.userAgent);');
    return userAgent;
  }

  static Future<List<String>> listCookies(
      WebViewController controller, BuildContext context) async {
    final String cookies =
        await controller.evaluateJavascript('document.cookie');
    // ignore: deprecated_member_use
    if (cookies == null || cookies == '""') {
      return [];
    }
    return cookies.split(';');
  }

  static void addToCache(WebViewController controller, String key, String value,
      {String storeName: "webviewCache"}) async {
    await controller.evaluateJavascript(
        'caches.open("$storeName"); localStorage["$key"] = "$value";');
  }

  static void listCache(
      WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript('caches.keys()'
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  static void clearCache(
      WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text("清除缓存成功."),
    ));
  }

  static void clearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = '清除Cookies失败';
    if (!hadCookies) {
      message = '清除Cookies成功';
    }
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static void webviewNavigationDelegate(WebViewController controller,
      BuildContext context) async {
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(navigationPage));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }
}
