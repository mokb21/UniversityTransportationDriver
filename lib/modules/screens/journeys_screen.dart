import 'package:flutter/material.dart';
import 'package:university_transportation_driver/config/themes/theme_constants.dart';
import 'package:university_transportation_driver/constants/routing_constants.dart';
import 'package:university_transportation_driver/modules/models/journey_model.dart';
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';
import 'package:university_transportation_driver/utils/services/journey/journey_service.dart';
import 'package:university_transportation_driver/utils/services/journey/journey_service_web.dart';
import 'package:university_transportation_driver/widgets/loader.dart';

class JourneysScreen extends StatefulWidget {
  JourneysScreen({Key key}) : super(key: key);

  @override
  _JourneysScreenState createState() => _JourneysScreenState();
}

class _JourneysScreenState extends State<JourneysScreen> {
  final JourneyService _journeyService = new JourneyServiceWeb();
  List<JourneyModel> _journeys = <JourneyModel>[];

  bool _isLoading = false;

  initWidgetProperties() async {
    setState(() {
      _isLoading = true;
    });
    final loginModel = await SharedPreferencesHelper.getCurrentUser();
    final userId = loginModel.user.id;

    var journeys = await _journeyService.getJourneysByDriverIdAsync(userId);
    setState(() {
      if (journeys != null) _journeys = journeys;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initWidgetProperties();
  }

  @override
  Widget build(BuildContext context) {
    return _journeys.isEmpty
        ? Center(
            child: Text("No Data Found"),
          )
        : Stack(
            children: [
              ListView.builder(
                itemCount: _journeys.length,
                itemBuilder: (BuildContext ctxt, int i) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.timeline_sharp,
                        color: _journeys[i].isStarted
                            ? Colors.green
                            : ThemeConstants.PrimaryColor,
                        size: 45.0,
                      ),
                      title: Text(_journeys[i].name),
                      subtitle: Text(_journeys[i].startDate.split('T')[1]),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutingConstants.JourneyDetailsScreenRoute,
                            arguments: _journeys[i].id);
                      },
                    ),
                  );
                },
              ),
              _isLoading ? Loader() : Stack()
            ],
          );
  }
}
