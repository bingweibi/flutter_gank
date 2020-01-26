import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewRoute extends StatefulWidget {

  final String url;
  final String title;
  WebViewRoute({@required this.url, @required this.title});

  @override
  _WebViewRouteState createState() => _WebViewRouteState();
}

class _WebViewRouteState extends State<WebViewRoute> {

  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();


  @override
  void initState() {
    super.initState();
    _flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged stated){
      switch(stated.type){
        case WebViewState.finishLoad:
          break;
        case WebViewState.shouldStart:
          break;
        case WebViewState.startLoad:
          break;
        case WebViewState.finishLoad:
          break;
        case WebViewState.abortLoad:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flutterWebviewPlugin.dispose();
  }
}
