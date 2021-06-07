import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:university_transportation_driver/constants/api_path.dart';
import 'package:university_transportation_driver/modules/models/detailed_journey_station_model.dart';
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';
import 'package:university_transportation_driver/utils/services/station/station_service.dart';

class StationServiceWeb extends StationService {
  @override
  Future<List<DetailedJourneyStationModel>> getStationsByJourneyIdAsync(
      String journeyId) async {
    try {
      final loginModel = await SharedPreferencesHelper.getCurrentUser();
      final token = loginModel.token.token;

      final http.Response response = await http.get(
        Uri.http(ApiPath.DomainPath, '/api/Stations/GetByJourneyId',
            {"JourneyId": journeyId}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => DetailedJourneyStationModel.fromJson(i))
            .toList();
      }
      return null;
    } on Exception catch (_) {
      throw Exception('Oops Somthing went wrong');
    }
  }
}
