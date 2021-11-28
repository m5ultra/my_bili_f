import 'package:my_bili_f/db/hi_cache.dart';

enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  /// curl -X GET "https://api/devio.org/test/test?requestParams=11" -H "accept: */*"
  /// curl -X GET "https://api.devio.org/uapi/test/test/1"
  dynamic pathParams;
  dynamic useHttps = false;

  /// 返回baseUrl
  String authority() {
    return 'localhost:5288';
  }

  /// 请求方式 GET POST PUT DELETE
  HttpMethod httpMethod();

  String path();

  /// 返回请求完整地址
  String url() {
    Uri uri;
    String pathStr = path();
    if (needLogin()) {
      addHeader('token', HiCache.getInstance()!.get('token'));
    }

    ///拼接path参数
    if (pathParams != null) {
      if (path().endsWith('/')) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    if (useHttps) {
      httpMethod() == HttpMethod.GET
          ? uri = Uri.https(authority(), pathStr, params)
          : uri = Uri.https(authority(), pathStr);
    } else {
      httpMethod() == HttpMethod.GET
          ? uri = Uri.http(authority(), pathStr, params)
          : uri = Uri.http(authority(), pathStr);
    }
    if (uri.toString().endsWith('?')) {
      return uri
          .toString()
          .replaceRange(uri.toString().length - 1, uri.toString().length, '');
    } else {
      return uri.toString();
    }
  }

  bool needLogin();
  Map<String, String> params = {};

  /// 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {};

  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}

/// https://api.devio.org/uapi/swagger-ui.html  API文档
