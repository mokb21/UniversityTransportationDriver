class JourneyModel {
  String id;
  String name;
  String createDate;
  String lastUpdateDate;
  String startDate;
  String endDate;
  bool isAdditional;
  bool isRequestable;
  bool isRepeatable;
  bool isStarted;
  String repeatDays;
  String driverId;
  List<JourneyStations> journeyStations;

  JourneyModel(
      {this.id,
      this.name,
      this.createDate,
      this.lastUpdateDate,
      this.startDate,
      this.endDate,
      this.isAdditional,
      this.isRequestable,
      this.isRepeatable,
      this.isStarted,
      this.repeatDays,
      this.driverId,
      this.journeyStations});

  JourneyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createDate = json['createDate'];
    lastUpdateDate = json['lastUpdateDate'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    isAdditional = json['isAdditional'];
    isRequestable = json['isRequestable'];
    isRepeatable = json['isRepeatable'];
    isStarted = json['isStarted'];
    repeatDays = json['repeatDays'];
    driverId = json['driverId'];
    if (json['journeyStations'] != null) {
      journeyStations = <JourneyStations>[];
      json['journeyStations'].forEach((v) {
        journeyStations.add(new JourneyStations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createDate'] = this.createDate;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['isAdditional'] = this.isAdditional;
    data['isRequestable'] = this.isRequestable;
    data['isRepeatable'] = this.isRepeatable;
    data['isStarted'] = this.isStarted;
    data['repeatDays'] = this.repeatDays;
    data['driverId'] = this.driverId;
    if (this.journeyStations != null) {
      data['journeyStations'] =
          this.journeyStations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JourneyStations {
  String journeyId;
  String stationId;
  String arrivalDate;

  JourneyStations({this.journeyId, this.stationId, this.arrivalDate});

  JourneyStations.fromJson(Map<String, dynamic> json) {
    journeyId = json['journeyId'];
    stationId = json['stationId'];
    arrivalDate = json['arrivalDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['journeyId'] = this.journeyId;
    data['stationId'] = this.stationId;
    data['arrivalDate'] = this.arrivalDate;
    return data;
  }
}
