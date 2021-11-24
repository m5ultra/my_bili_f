enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  /// curl -X GET "https://api/devio.org/test/test?requestParams=11" -H "accept: */*"
  /// curl -X GET "https://api.devio.org/uapi/test/test/1"
  dynamic pathParams;
  dynamic useHttps = true;

  String authority() {
    return 'api.devio.org';
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    String pathStr = path();

    ///拼接path参数
    if (pathParams != null) {
      if (path().endsWith('/')) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print('url:${uri.toString()}');
    return uri.toString();
  }

  bool nedLogin();
  Map<String, String> params = {};

  /// 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, String> header = {};
  BaseRequest addHeader(String k, Object v) {
    params[k] = v.toString();
    return this;
  }
}

/// https://api.devio.org/uapi/swagger-ui.html  API文档
