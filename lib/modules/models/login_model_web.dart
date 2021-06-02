class LoginModelWeb {
  Token token;
  User user;

  LoginModelWeb({this.token, this.user});

  LoginModelWeb.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Token {
  String status;
  String token;
  String validTo;

  Token({this.status, this.token, this.validTo});

  Token.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    validTo = json['validTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['validTo'] = this.validTo;
    return data;
  }
}

class User {
  String id;
  int role;
  String userName;
  String email;
  String phone;

  User({this.id, this.role, this.userName, this.email, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}