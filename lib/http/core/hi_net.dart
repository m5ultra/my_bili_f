import 'package:my_bili_f/http/core/hi_net_adapter.dart';
import 'package:my_bili_f/http/request/base_request.dart';

import 'dio_adapter.dart';
import 'hi_error.dart';

class HiNet {
  /// 贾鹏飞
  // HiNet._();
  //
  // static HiNet? _instance;
  //
  // static HiNet? getInstance() {
  //   _instance ??= HiNet._();
  //   return _instance;
  // }

  /// 普通单利
  static HiNet? _instance;

  static get instance {
    _instance ??= HiNet._internal();
    return _instance;
  }

  HiNet._internal();

  /// 工厂函数模式
  // HiNet._internal();
  //
  // factory HiNet() => _instance;
  // static late final HiNet _instance = HiNet._internal();

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    Object? error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      // 其他异常
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response?.data;
    printLog(result);
    dynamic status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
      case 409:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) {
    printLog('url: ${request.url()}');

    /// 使用mock 发送数据
    // HiNetAdapter adapter = MockAdapter();
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('hi_net:${log.toString()}');
  }
}
