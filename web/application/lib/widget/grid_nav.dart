import 'package:application/model/common_model.dart';
import 'package:application/model/gird_nav_model.dart';
import 'package:application/widget/web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///网格卡片
class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;

  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
        // 设置圆角
      borderRadius: BorderRadius.all(Radius.circular(6)),
      clipBehavior: Clip.antiAlias,
      child: Column(
          children: _girdNavItems(context)
      ),
    );
  }

  _girdNavItems(BuildContext context){
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      items.add(_girdNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_girdNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_girdNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _girdNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2, true));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4, false));
    List<Widget> extandItems = [];
    items.forEach((item) {
      extandItems.add(Expanded(child: item,flex: 1));
    });
    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    return Container(
      height: 88,
      margin: first?null:EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        // 线程渐变
        gradient: LinearGradient(colors: [startColor, endColor])
      ),
      child: Row(
        children: extandItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel commonModel) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WebView(
          url: commonModel.url,
          statusBarColor: commonModel.statusBarColor,
          hideAppBar: commonModel.hideAppBar,
          title: commonModel.title
        )));
      },
      child: Stack(
        children: <Widget>[
          Image.network(commonModel.icon, fit: BoxFit.contain, height: 88, width: 121, alignment: AlignmentDirectional.bottomEnd),
          Text(commonModel.title, style: TextStyle(fontSize: 14, color: Colors.white))
        ],
      ),
    );
  }

  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem, bool isCenter) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topItem, true, isCenter),
        ),
        Expanded(
          child: _item(context, bottomItem, false, isCenter),
        )
      ],
    );

  }

  _item(BuildContext context, CommonModel item, bool first, bool isCenter) {
    BorderSide borderSide = new BorderSide(width: 0.8, color: Colors.white);
    //撑满父布局宽度
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first?borderSide:BorderSide.none
          )
        ),
        child: _wrapGesture(context, Center(
            child: Text(item.title, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.white))
        ), item)
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => WebView(
            url: model.url,
          )
        ));
      },
      child: widget
    );
  }
}
