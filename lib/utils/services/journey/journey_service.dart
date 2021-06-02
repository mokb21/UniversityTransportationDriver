import 'package:university_transportation_driver/modules/models/journey_model.dart';

abstract class JourneyService {
  Future<List<JourneyModel>> getJourneysByDriverIdAsync(String driverId);
  
  Future<JourneyModel> getJourneyByIdAsync(String id);
}
