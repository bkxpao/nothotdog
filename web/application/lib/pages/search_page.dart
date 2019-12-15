import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('搜索'),
      )
    );
  }

}