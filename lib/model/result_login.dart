class LoginResult {
  int status = -1;
  String msg = '';
  bool success = false;
  String token = '';

  LoginResult(this.status, this.msg, this.success, this.token);

  LoginResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    success = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['msg'] = msg;
    data['success'] = success;
    data['token'] = token;
    return data;
  }
}
