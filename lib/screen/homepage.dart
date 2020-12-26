import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Amazan Webview'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: 'https://www.amazon.com',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webviewController) {
            _controller.complete(webviewController);
          },
        ),
        floatingActionButton: FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> controller) {
            Future<String> getUrl() async {
              dynamic url = await controller.data.currentUrl();
              print('Current Link is: $url\n\n\n');

              return url;
            }

            if (controller.hasData) {
              return FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(Icons.copy),
                tooltip: 'Copy The URL',
                onPressed: () {
                  print('\n\n\nLink Copied');
                  getUrl();
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
