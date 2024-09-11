import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peach/config/_.dart';
import 'package:peach/utils/_.dart';
import 'package:toast/toast.dart';

class ResponseData {
  String code;
  String message;
  dynamic data;
}

/// 单例模式封装 dio
class HttpApi {
  Dio _Dio;
  static HttpApi _instance = HttpApi.instance();
  factory HttpApi() => _instance;

  HttpApi.instance() {
    SPreferences.init();
    if (null == _Dio) {
      BaseOptions options = new BaseOptions(
        baseUrl: Config.ApiUrl['PhotoBaseUrl'],
        connectTimeout: 30000,
        contentType: 'application/json; charset=utf-8',
        responseType: ResponseType.json,
      );

      _Dio = new Dio(options);
      _Dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // print(SPreferences().getString("token"));
        // options.headers
        options.headers.putIfAbsent("token", () => SPreferences().getString("token"));
        // 请求拦截器
        return options;
      }, onResponse: (Response response) {

        // 因为 downloadFile 下载apk方法被响应拦截器拦截了，所以这里需要对下载的
        // 响应头进行判断，如果是阿里云，则不进行状态码的判断
        if (response.headers.value("server") == "AliyunOSS") {
          return response;
        } else {
          switch (response.data["code"]) {
            case 404:
            // BotToast.showText(text: response.data["message"]);
              return response;
            case 100:
              return response;
            case 500:
              BotToast.showText(text: response.data["message"]);
              throw response.data["message"];
            default:
              return response;
          }
        }
      }, onError: (DioError e) {
        print("网络请求出现错误 ====== ${e.message}");
        // 错误拦截器
        return e;
      }));
    }
  }

  /// GET 请求
  Future get({@required String url, Options options, dynamic params}) async {
    Response res =
        await _Dio.get(url, queryParameters: params, options: options);
    return res.data;
  }

  /// POST 请求
  Future post({@required String url, Options options, dynamic params}) async {
    Response res = await _Dio.post(url, data: params, options: options);
    return res.data;
  }

  /// 下载文件
  Future downloadFile(String urlPath, String savePath, {ProgressCallback onReceiveProgress}) async {
    Response response = await _Dio.download(urlPath, savePath,
        onReceiveProgress: onReceiveProgress,
        options: Options(sendTimeout: 25000, receiveTimeout: 25000));
    return response;
  }
}
