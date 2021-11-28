import 'package:my_bili_f/http/request/base_request.dart';

class LoginRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool nedLogin() {
    return false;
  }

  @override
  String path() {
    return '/users/login';
  }
}
