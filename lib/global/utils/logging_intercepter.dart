import 'package:dio/dio.dart';

import 'logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.logPrint("--> ${options.method} ${options.uri}");
    Logger.logPrint("headers: ${options.headers}");
    Logger.logPrint("data:::: ${options.data}");
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(response, ResponseInterceptorHandler handler) async {
    Logger.logPrint("--> ${response.statusCode} RESPONSE::: $response");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Logger.logPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    Logger.logPrint(err.message);
    Logger.logPrint(err.response);
    return super.onError(err, handler);
  }
}
