class TripModel {
  String id;
  String startDate;
  String endDate;
  String journeyId;

  TripModel({this.id, this.startDate, this.endDate, this.journeyId});

  TripModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    journeyId = json['journeyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['journeyId'] = this.journeyId;
    return data;
  }
}
