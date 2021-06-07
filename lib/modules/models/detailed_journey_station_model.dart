class DetailedJourneyStationModel {
  String id;
  String name;
  double longitude;
  double latitude;
  String createDate;
  String lastUpdateDate;
  String arrivalDate;

  DetailedJourneyStationModel(
      {this.id,
      this.name,
      this.longitude,
      this.latitude,
      this.createDate,
      this.lastUpdateDate,
      this.arrivalDate});

  DetailedJourneyStationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createDate = json['createDate'];
    lastUpdateDate = json['lastUpdateDate'];
    arrivalDate = json['arrivalDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['createDate'] = this.createDate;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['arrivalDate'] = this.arrivalDate;
    return data;
  }
}