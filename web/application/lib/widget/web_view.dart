import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView({Key key, this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid = false}) : super(key: key);
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url){

    });

    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type) {
        case WebViewState.startLoad:
          break;
        default:
          break;
      }
    });
    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error){
      print(error);
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          // 六位颜色转换Color方法：int.parse('0xff'+六位颜色)
          _appBar(Color(int.parse('0xff'+statusBarColorStr)),  backButtonColor),
          Expanded(child: WebviewScaffold(
            url: widget.url,
            withZoom: true, // 是否可以缩放
            withLocalStorage: true, // 是否启用本地缓存
            hidden: true, //是否隐藏
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('Waiting...')
              ),
            ), // 在url没读出来之前的加载条
          ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar??false) {
      return Container(
        color: backgroundColor,
        height: 30
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left:10),
                child: Icon(Icons.close, color: backButtonColor,size: 26),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(widget.title??'', style: TextStyle(color: backButtonColor, fontSize: 18))
              ),
            )
          ],
        ),
      ),
    );
  }
}
