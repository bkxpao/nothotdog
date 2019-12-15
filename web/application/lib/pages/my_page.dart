import 'package:flutter/material.dart';

class MyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('我的'),
      )
    );
  }

}