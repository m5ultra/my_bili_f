import 'package:my_bili_f/http/request/base_request.dart';

class HiNet {
  HiNet._();

  static HiNet? _instance;

  static HiNet? getInstance() {
    _instance ??= HiNet._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    var response = await send(request);
    var result = response['data'];
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) {
    printLog('url: ${request.url()}');
    printLog('method: ${request.httpMethod()}');
    request.addHeader('token', '123');
    printLog('header: ${request.header}');
    return Future.value(
      {
        "stateCode": 200,
        "data": {"code": 200},
      },
    );
  }

  void printLog(log) {
    print('hi_net:${log.toString()}');
  }
}
