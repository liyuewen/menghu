import 'package:dio/dio.dart';
import 'package:peach/config/_.dart';
import 'package:peach/http/Dio.dart';
import 'package:peach/entity/_.dart';

class PublicService {
  // 上传文件
  static Future<ToolUploadFileEntityData> toolUploadFile(
      FormData params) async {
    var res = await HttpApi()
        .post(url: Config.ApiUrl['ApiList']['toolUploadFile'], params: params);
    return ToolUploadFileEntityList.fromJson(res).data;
  }

  /// App更新接口
  static Future<Data> update({ Map<String, dynamic> params }) async {
    var res = await HttpApi().post(
        url: Config.ApiUrl['ApiList']['Update'],
        params: params
    );
    return UpdateVersionEntity.fromJson(res).data;
  }
}
