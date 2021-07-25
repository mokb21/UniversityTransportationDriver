import 'package:flutter/material.dart';
import 'package:university_transportation_driver/config/themes/theme_constants.dart';
import 'package:university_transportation_driver/modules/models/detailed_journey_station_model.dart';
import 'package:university_transportation_driver/utils/services/station/station_service.dart';
import 'package:university_transportation_driver/utils/services/station/station_service_web.dart';
import 'package:university_transportation_driver/widgets/loader.dart';

// ignore: must_be_immutable
class JourneyStationsList extends StatefulWidget {
  String journeyId;

  JourneyStationsList({Key key, this.journeyId}) : super(key: key);

  @override
  _JourneyStationsListState createState() => _JourneyStationsListState();
}

class _JourneyStationsListState extends State<JourneyStationsList> {
  final StationService _stationService = new StationServiceWeb();
  List<DetailedJourneyStationModel> _stations = <DetailedJourneyStationModel>[];

  bool _isLoading = false;

  initWidgetProperties() async {
    setState(() {
      _isLoading = true;
    });

    List<DetailedJourneyStationModel> stations =
        await _stationService.getStationsByJourneyIdAsync(widget.journeyId);

    setState(() {
      _stations = stations;
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
    return Stack(
      children: [
        ListView.builder(
          itemCount: _stations.length,
          itemBuilder: (BuildContext ctxt, int i) {
            return Card(
              child: ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: ThemeConstants.PrimaryColor,
                  size: 45.0,
                ),
                title: Text(_stations[i].name),
                subtitle: Text(_stations[i].arrivalDate.split('T')[1]),
              ),
            );
          },
        ),
        _isLoading ? Loader() : Stack()
      ],
    );
  }
}
