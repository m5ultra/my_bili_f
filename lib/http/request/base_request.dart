enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  /// curl -X GET "https://api/devio.org/test/test?requestParams=11" -H "accept: */*"
  /// curl -X GET "https://api.devio.org/uapi/test/test/1"
  dynamic pathParams;
  dynamic useHttps = true;

  /// 返回baseUrl
  String authority() {
    return 'api.devio.org';
  }

  /// 请求方式 GET POST PUT DELETE
  HttpMethod httpMethod();

  String path();

  /// 返回请求完整地址
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
    if (uri.toString().endsWith('?')) {
      return uri
          .toString()
          .replaceRange(uri.toString().length - 1, uri.toString().length, '');
    } else {
      return uri.toString();
    }
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
    header[k] = v.toString();
    return this;
  }
}

/// https://api.devio.org/uapi/swagger-ui.html  API文档
