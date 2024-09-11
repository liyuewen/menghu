import 'package:peach/config/_.dart';
import 'package:peach/entity/EmptyEntity.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/http/Dio.dart';

class DynamicService {
  // 动态列表
  static Future<DynamicPersonalDynamicEntityData> dynamicPersonalDynamic(
      Map<String, dynamic> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['dynamicPersonalDynamic'],
        params: params);
    return DynamicPersonalDynamicEntityList.fromJson(res).data;
  }

  /*
  * 发布动态
  */
  static Future<Null> dynamicPush(Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['dynamicPush'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }

  /*
  * 底部tabbar的动态列表
  */
  static Future<DynamicTabsDynamicEntityData> dynamicTabsDynamic(
      Map<String, dynamic> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['dynamicTabsDynamic'], params: params);
    return DynamicTabsDynamicEntityList.fromJson(res).data;
  }

  /*
  * 【需要Token】获取【最常访问】用户列表
  */
  static Future<DynamicDynamicHistoryEntityData> dynamicDynamicHistory(
      Map<String, dynamic> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['dynamicDynamicHistory'], params: params);
    return DynamicDynamicHistoryEntityList.fromJson(res).data;
  }

  /*
  * 动态详情
  */
  static Future<DynamicInfoEntityData> dynamicInfo(
      Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['dynamicInfo'], params: params);
    return DynamicInfoEntityList.fromJson(res).data;
  }
}
