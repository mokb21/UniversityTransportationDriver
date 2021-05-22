class LoginModel {
  String userName;
  String password;
  bool rememberMe;

  LoginModel({this.userName, this.password, this.rememberMe});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    rememberMe = json['rememberMe'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['rememberMe'] = this.rememberMe ?? false;
    return data;
  }
}
