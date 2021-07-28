import 'package:university_transportation_driver/modules/models/passenger_model.dart';
import 'package:university_transportation_driver/modules/models/trip_model.dart';

abstract class TripService {
  Future<TripModel> startTrip(String journeyId);
  Future<TripModel> endTrip(String journeyId);
  Future<List<PassengerModel>> getPassengers(String journeyId);
  Future<PassengerModel> addPassenger(String journeyId, String qrCode);
}
