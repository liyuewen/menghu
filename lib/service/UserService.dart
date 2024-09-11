import 'package:peach/config/_.dart';
import 'package:peach/http/Dio.dart';
import 'package:peach/entity/_.dart';

class UserService {
  // 登录接口
  static Future<LoginData> Login(Map<String, String> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['login'], params: params);
    return LoginList.fromJson(res).data;
  }

  // 注册接口
  static Future<RegData> Reg(Map<String, String> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['reg'], params: params);
    return RegList.fromJson(res).data;
  }

  // 获取个人信息
  static Future<UserInfoPersonalEntityData> UserInfo(
      Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['UserInfo'], params: params);
    return UserInfoPersonalEntityList.fromJson(res).data;
  }

  // 获取粉丝列表
  static Future<FansUserListEntityData> getFansUserList(
      Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['FansUserList'], params: params);
    return FansUserListEntityList.fromJson(res).data;
  }

  // 获取关注列表
  static Future<FollowUserListEntityData> getFollowUserList(
      Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['FollowUserList'], params: params);
    return FollowUserListEntityList.fromJson(res).data;
  }
}
