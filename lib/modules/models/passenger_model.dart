class PassengerModel {
  String id;
  String userName;
  String email;
  String phone;
  String qrCode;
  String universityId;

  PassengerModel(
      {this.id,
      this.userName,
      this.email,
      this.phone,
      this.qrCode,
      this.universityId});

  PassengerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    qrCode = json['qrCode'];
    universityId = json['universityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['qrCode'] = this.qrCode;
    data['universityId'] = this.universityId;
    return data;
  }
}