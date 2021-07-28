import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:university_transportation_driver/constants/api_path.dart';
import 'package:university_transportation_driver/modules/models/trip_model.dart';
import 'package:university_transportation_driver/modules/models/passenger_model.dart';
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';
import 'package:university_transportation_driver/utils/services/trip/trip_service.dart';

class TripServiceWeb extends TripService {
  @override
  Future<TripModel> startTrip(String journeyId) async {
    try {
      final loginModel = await SharedPreferencesHelper.getCurrentUser();
      final token = loginModel.token.token;

      final http.Response response = await http.get(
        Uri.http(
            ApiPath.DomainPath, '/api/Trips/Start', {"JourneyId": journeyId}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map parsed = json.decode(response.body);
        return TripModel.fromJson(parsed);
      }
      return null;
    } on Exception catch (_) {
      throw Exception('Oops Somthing went wrong');
    }
  }

  @override
  Future<TripModel> endTrip(String journeyId) async {
    try {
      final loginModel = await SharedPreferencesHelper.getCurrentUser();
      final token = loginModel.token.token;

      final http.Response response = await http.get(
        Uri.http(
            ApiPath.DomainPath, '/api/Trips/End', {"JourneyId": journeyId}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map parsed = json.decode(response.body);
        return TripModel.fromJson(parsed);
      }
      return null;
    } on Exception catch (_) {
      throw Exception('Oops Somthing went wrong');
    }
  }

  @override
  Future<List<PassengerModel>> getPassengers(String journeyId) async {
    try {
      final loginModel = await SharedPreferencesHelper.getCurrentUser();
      final token = loginModel.token.token;

      final http.Response response = await http.get(
        Uri.http(ApiPath.DomainPath, '/api/Trips/GetPassengers',
            {"JourneyId": journeyId}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => PassengerModel.fromJson(i))
            .toList();
      }
      return null;
    } on Exception catch (_) {
      throw Exception('Oops Somthing went wrong');
    }
  }

  @override
  Future<PassengerModel> addPassenger(String journeyId, String qrCode) async {
    try {
      final loginModel = await SharedPreferencesHelper.getCurrentUser();
      final token = loginModel.token.token;

      final http.Response response = await http.get(
        Uri.http(ApiPath.DomainPath, '/api/Trips/AddPassenger',
            {"JourneyId": journeyId, "qrCode": qrCode}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map parsed = json.decode(response.body);
        return PassengerModel.fromJson(parsed);
      }
      return null;
    } on Exception catch (_) {
      throw Exception('Oops Somthing went wrong');
    }
  }
}
