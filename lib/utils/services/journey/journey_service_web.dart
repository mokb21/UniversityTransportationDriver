import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:university_transportation_driver/constants/api_path.dart';
import 'package:university_transportation_driver/modules/models/journey_model.dart';
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';
import 'package:university_transportation_driver/utils/services/journey/journey_service.dart';

class JourneyServiceWeb extends JourneyService {
  @override
  Future<List<JourneyModel>> getJourneysByDriverIdAsync(String driverId) async {
    try {
      final loginModel = await SharedPreferencesHelper.getCurrentUser();
      final token = loginModel.token.token;

      final http.Response response = await http.get(
        Uri.http(ApiPath.DomainPath, '/api/Journeys/GetByDriverId',
            {"DriverId": driverId}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => JourneyModel.fromJson(i))
            .toList();
      }
      return null;
    } on Exception catch (_) {
      throw Exception('Oops Somthing went wrong');
    }
  }

  @override
  Future<JourneyModel> getJourneyByIdAsync(String id) async {
    try {
      final loginModel = await SharedPreferencesHelper.getCurrentUser();
      final token = loginModel.token.token;

      final http.Response response = await http.get(
        Uri.http(ApiPath.DomainPath, '/api/Journeys/Get', {"Id": id}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map parsed = json.decode(response.body);
        return JourneyModel.fromJson(parsed);
      }
      return null;
    } on Exception catch (_) {
      throw Exception('Oops Somthing went wrong');
    }
  }
}
