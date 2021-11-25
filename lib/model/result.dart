import 'package:json_annotation/json_annotation.dart';

// result.g.dart 将在我们运行生成命令后自动生成
part 'result.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Result {
  Result(this.name, this.face, this.fans, this.userInfo);

  String name;
  String face;
  double fans;
  UserInfo userInfo;
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UserInfo {
  UserInfo(this.name, this.age);

  String name;
  int age;
  //不同的类使用不同的mixin即可
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
