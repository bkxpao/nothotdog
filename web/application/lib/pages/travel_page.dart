import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TravelPage();
}

class _TravelPage extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('旅拍'),
      )
    );
  }

}