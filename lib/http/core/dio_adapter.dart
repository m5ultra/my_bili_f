import 'package:dio/dio.dart';
import 'package:my_bili_f/http/core/hi_error.dart';
import 'package:my_bili_f/http/core/hi_net_adapter.dart';
import 'package:my_bili_f/http/request/base_request.dart';

/// Dio 适配器

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    var error;
    var _dio = Dio();

    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await _dio.get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        // try {
        //   _dio.options.connectTimeout = 5000;
        //   _dio.options.receiveTimeout = 3000;
        //   response = await _dio.post(
        //     'http://localhost:5288/users/login',
        //     data: {"name": "卡布奇诺", "password": "123456"},
        //   );
        // } catch (e) {
        //   print(e);
        // }
        response = await _dio.post(request.url(),
            data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await _dio.delete(request.url(),
            data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      /// 抛出HiNetError
      throw HiNetError(response?.stateCode ?? -1, error.toString(),
          data: BuildRes(response, request));
    }
    return BuildRes<T>(response, request);
  }

  /// 构建HiNetResponse
  HiNetResponse<T> BuildRes<T>(Response response, BaseRequest request) {
    return HiNetResponse<T>(
      data: response.data,
      request: request,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response,
    );
  }
}
