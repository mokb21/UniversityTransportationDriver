import 'package:university_transportation_driver/modules/models/detailed_journey_station_model.dart';

abstract class StationService {
  Future<List<DetailedJourneyStationModel>> getStationsByJourneyIdAsync(
      String journeyId);
}
