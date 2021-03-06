import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  @override
  WebviewPageState createState() => WebviewPageState();

  WebviewPage({
    @required this.title,
    @required this.url,
  });

  final String title;
  final String url;
}

class WebviewPageState extends State<WebviewPage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  bool isLoaded;
  @override
  void initState() {
    super.initState();
    isLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: widget.title,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.info),
                onPressed: (){

                }
            )
          ],
      ),
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              javascriptChannels: <JavascriptChannel>[
                _toasterJavascriptChannel(context),
              ].toSet(),
              navigationDelegate: (NavigationRequest request) {
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                setState(() {
                  isLoaded = true;
                });
              },
              gestureNavigationEnabled: true,
            ),
            (isLoaded == false) ? Center(child: CircularProgressIndicator(),) : Container()
          ],
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}