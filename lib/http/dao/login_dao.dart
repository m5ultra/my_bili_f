import 'package:my_bili_f/http/core/hi_net.dart';
import 'package:my_bili_f/http/request/base_request.dart';
import 'package:my_bili_f/http/request/login_request.dart';
import 'package:my_bili_f/http/request/registration_request.dart';

class LoginDao {
  static login(String name, String password) {
    return _send(name, password);
  }

  static registration(
      String name, String password, String imoocId, String orderId) {
    return _send(name, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String name, String password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
      request
          .add('name', name)
          .add('password', password)
          .add('imoocId', imoocId)
          .add('orderId', orderId);
    } else {
      request = LoginRequest();
      request.add('name', name).add('password', password);
    }
    return await HiNet.instance.fire(request);
  }
}
