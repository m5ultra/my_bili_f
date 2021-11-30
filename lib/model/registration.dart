class RegistrationResult {
  int code = 0;
  String msg = '';

  RegistrationResult(this.code, this.msg);

  RegistrationResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    return data;
  }
}
