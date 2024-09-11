import 'package:peach/config/_.dart';
import 'package:peach/http/Dio.dart';
import 'package:peach/entity/_.dart';

class OpusService {
  // 获取首页推荐列表
  static Future<OpusRecommendData> getOpusRecommend(
      Map<String, int> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['opusRecommend'], params: params);
    return OpusRecommendList.fromJson(res).data;
  }

  // 获取作品详情
  static Future<OpusOpusInfoEntityData> getOpusOpusInfo(
      Map<String, int> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['opusOpusInfo'], params: params);
    return OpusOpusInfoEntityList.fromJson(res).data;
  }

  // 判断当前用户是否被关注
  static Future<bool> isCheckUserIsFollow(Map<String, int> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['checkUserIsFollow'], params: params);
    return CheckUserIsFollowEntityList.fromJson(res).data;
  }

  // 关注和取消关注
  static Future<bool> opusFollowUser(Map<String, int> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['opusFollowUser'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }

  // 检查作品是否被点赞
  static Future<bool> opusCheckOpusIsUpvote(Map<String, int> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['opusCheckOpusIsUpvote'], params: params);
    return CheckUserIsFollowEntityList.fromJson(res).data;
  }

  // 点赞和取消点赞
  static Future<bool> opusUpvoteOpus(Map<String, int> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['opusUpvoteOpus'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }

  // 发布作品
  static Future<Null> opusPushOpus(Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['opusPushOpus'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }

  // 检查作品是否被收藏
  static Future<bool> opusCheckOpusIsCollection(Map<String, int> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['opusCheckOpusIsCollection'],
        params: params);
    return CheckUserIsFollowEntityList.fromJson(res).data;
  }

  // 作品收藏和取消收藏
  static Future<bool> opusCollectionOpus(Map<String, int> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['opusCollectionOpus'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }

  // 排行列表
  static Future<OpusRankingEntityData> opusRanking(
      Map<String, int> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['opusRanking'], params: params);
    return OpusRankingEntityList.fromJson(res).data;
  }

  // 搜索接口
  static Future<dynamic> opusSearch(Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['opusOpusSearch'], params: params);
    return res;
  }

  // 收藏列表
  static Future<CollectionOpusListEntityData> collectionOpusList(
      Map<String, dynamic> params) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['CollectionOpusList'], params: params);
    return CollectionOpusListEntityList.fromJson(res).data;
  }

  // 获取关注用户的作品
  static Future<FollowData> getFollow(Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['Follow'], params: params);
    return FollowList.fromJson(res).data;
  }

  // 获取个人空间的投稿列表，用的首页推荐的实体
  static Future<OpusListEntityData> getOpusList(Map<String, int> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['getOpusList'], params: params);
    return OpusListEntityList.fromJson(res).data;
  }
}
