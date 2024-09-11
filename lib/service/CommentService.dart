import 'package:peach/config/_.dart';
import 'package:peach/entity/CommenListEntity.dart';
import 'package:peach/entity/EmptyEntity.dart';
import 'package:peach/entity/_.dart';
import 'package:peach/http/Dio.dart';

class CommentService {
  // 发评论
  static Future<Null> commentAdd(Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['commentAdd'], params: params);
    return EmptyEntityList.fromJson(res).data;
  }

  // 评论列表
  static Future<CommenListEntityData> getCommentList(
      Map<String, dynamic> params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['commentList'], params: params);
    return CommenListEntityList.fromJson(res).data;
  }
}
