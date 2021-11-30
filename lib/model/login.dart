import 'package:json_annotation/json_annotation.dart';

// result.g.dart 将在我们运行生成命令后自动生成
part 'login.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Login {
  Login(this.status, this.msg, this.success, this.token);
  int status;
  String msg;
  bool success;
  String token;
  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
