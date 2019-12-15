import 'dart:convert';

import 'package:application/model/home_model.dart';
import 'package:http/http.dart' as http;
const HOME_URL = 'http://111.229.170.190:8080/homepage';
// 首页大接口
class HomeDao{
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Fail to load homepage');
    }
  }
}