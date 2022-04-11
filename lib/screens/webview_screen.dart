import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutternews/model/article.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  static const String id = 'webview_screen';

  const WebviewScreen({Key? key}) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Article article =
        ModalRoute.of(context)!.settings.arguments as Article;

    bool showSpinner = false;

    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: WebView(
        initialUrl: article.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String s) {
          setState(() {
            showSpinner = true;
          });
        },
        onPageFinished: (String s) {
          setState(() {
            showSpinner = false;
          });
        },
      ),
    ));
  }
}
