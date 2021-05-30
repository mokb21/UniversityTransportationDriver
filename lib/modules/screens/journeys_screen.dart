import 'package:flutter/material.dart';
import 'package:university_transportation_driver/modules/models/journey_model.dart';
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';
import 'package:university_transportation_driver/utils/services/journey/journey_service.dart';
import 'package:university_transportation_driver/utils/services/journey/journey_service_web.dart';

class JourneysScreen extends StatefulWidget {
  JourneysScreen({Key key}) : super(key: key);

  @override
  _JourneysScreenState createState() => _JourneysScreenState();
}

class _JourneysScreenState extends State<JourneysScreen> {
  final JourneyService _journeyService = new JourneyServiceWeb();
  List<JourneyModel> _journeys = <JourneyModel>[];

  initWidgetProperties() async {
    final loginModel = await SharedPreferencesHelper.getCurrentUser();
    final userId = loginModel.user.id;

    var journeys = await _journeyService.getJourneysByDriverIdAsync(userId);
    setState(() {
      _journeys = journeys;
    });
  }

  @override
  void initState() {
    super.initState();
    initWidgetProperties();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _journeys.length,
      itemBuilder: (BuildContext ctxt, int i) {
        return new Card(
          child: Column(
            children: [
              Text(_journeys[i].name),
              Text(_journeys[i].startDate),
            ],
          ),
        );
      },
    );
  }
}
