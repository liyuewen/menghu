import 'package:dio/dio.dart';
import 'package:peach/config/_.dart';
import 'package:peach/http/Dio.dart';
import 'package:peach/entity/_.dart';

class TagService {
  // 推荐话题
  static Future<List<TagRecommendTagEntityData>> tagRecommendTag(
      Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['tagRecommendTag'], params: params);
    return TagRecommendTagEntityList.fromJson(res).data;
  }

  // 作品标签
  static Future<List<OpusTagEntityData>> tagOpusTag(
      Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['OpusTag'], params: params);
    return OpusTagEntityList.fromJson(res).data;
  }

  // 新增标签
  static Future<Null> tagOpusInfoCreatedTags(
      Map<String, dynamic> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['OpusInfoCreatedTags'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }

  // 修改当前标签编辑状态
  static Future<Null> tagUpdateTagsEditStatus(
      Map<String, dynamic> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['UpdateTagsEditStatus'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }

  // 删除标签
  static Future<Null> tagDeleteTag(Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['DeleteTag'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }
}
