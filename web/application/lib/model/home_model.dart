import 'package:application/model/common_model.dart';
import 'package:application/model/config_model.dart';
import 'package:application/model/gird_nav_model.dart';
import 'package:application/model/sales_box_model.dart';

class HomeModel{
  final ConfigModel configModel;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel({this.configModel, this.bannerList, this.localNavList, this.subNavList, this.gridNav, this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic>json) {
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((i) =>
        CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((i) =>
        CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((i) =>
        CommonModel.fromJson(i)).toList();

    return HomeModel(
      configModel: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList
    );
  }

  @override
  String toString() {
    return 'HomeModel{configModel: $configModel, bannerList: $bannerList, localNavList: $localNavList, subNavList: $subNavList, gridNav: $gridNav, salesBox: $salesBox}';
  }

}