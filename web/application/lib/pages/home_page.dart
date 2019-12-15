import 'package:application/dao/home_dao.dart';
import 'package:application/model/common_model.dart';
import 'package:application/model/gird_nav_model.dart';
import 'package:application/model/home_model.dart';
import 'package:application/widget/grid_nav.dart';
import 'package:application/widget/local_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List _imageUrls = [
    'http://111.229.170.190:8080/static/1.jpg',
    'http://111.229.170.190:8080/static/2.jpg',
    'http://111.229.170.190:8080/static/3.jpg',
  ];
  String resultString = "";
  List<CommonModel> localNavList = [];
  GridNavModel gridNavList;

  @override
  void initState(){
    Future.delayed(Duration(milliseconds: 600),(){
      //TODO Hide
    });
    super.initState();
    loadData();
  }

  loadData() async{
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e){
//      setState(() {
//        resultString = e.toString();
//      });
//    });
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavList = model.gridNav;
      });
    } catch (e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 160,
              child: Swiper(
                itemCount: _imageUrls.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index){
                  return Image.network(_imageUrls[index], fit: BoxFit.fill,);
                },
                pagination: new SwiperPagination()
              ),

            ),
            Padding(
              child: LocalNav(localNavList: localNavList),
              padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            ),
            Padding(
              child: GridNav(gridNavModel: gridNavList),
              padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
            ),
            Container(
              child: Text('11'),
            )
          ],
        ),
      )
    );
  }

}