class Owner {
  String? name;
  String? face;
  int? fans;
  UserInfo? userInfo;

  Owner(this.name, this.face, this.fans, this.userInfo);

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
    userInfo =
        json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['face'] = this.face;
    data['fans'] = this.fans;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo?.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? name;
  int? age;

  UserInfo(this.name, this.age);

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    return data;
  }
}
