import 'package:flutter/material.dart';
import 'package:university_transportation_driver/config/themes/theme_constants.dart';
import 'package:university_transportation_driver/modules/models/journey_model.dart';
import 'package:university_transportation_driver/modules/models/trip_model.dart';
import 'package:university_transportation_driver/utils/services/trip/trip_service.dart';
import 'package:university_transportation_driver/utils/services/trip/trip_service_web.dart';

// ignore: must_be_immutable
class JourneyBasicDetails extends StatefulWidget {
  JourneyModel journeyModel;
  JourneyBasicDetails({Key key, this.journeyModel}) : super(key: key);

  @override
  _JourneyBasicDetailsState createState() => _JourneyBasicDetailsState();
}

class _JourneyBasicDetailsState extends State<JourneyBasicDetails> {
  final TripService _tripService = new TripServiceWeb();

  _startEndPressed() async {
    TripModel trip;

    if (widget.journeyModel.isStarted)
      trip = await _tripService.endTrip(widget.journeyModel.id);
    else
      trip = await _tripService.startTrip(widget.journeyModel.id);

    if (trip != null)
      setState(() {
        widget.journeyModel.isStarted = !widget.journeyModel.isStarted;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                Text(
                  widget.journeyModel.name,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: ThemeConstants.PrimaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Chip(
                    padding: EdgeInsets.all(0),
                    backgroundColor: ThemeConstants.PrimaryColor,
                    label: Text(
                        _getJourneyRepeatDays(widget.journeyModel.repeatDays),
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Text(
                      'Start: ' + widget.journeyModel.startDate.split('T')[1]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  child:
                      Text('End: ' + widget.journeyModel.endDate.split('T')[1]),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: widget.journeyModel.isStarted
                          ? Colors.red
                          : ThemeConstants.PrimaryColor,
                    ),
                    onPressed: _startEndPressed,
                    child: Text(
                      widget.journeyModel.isStarted
                          ? 'Stop Journey'
                          : 'Start Journey',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getJourneyRepeatDays(String value) {
    if (value == null) return 'Not Repeatable';

    String repeatDays = '';
    List<String> valuesList = value.split(',');

    for (var i = 0; i < valuesList.length; i++) {
      if (i > 0) repeatDays += ', ';

      switch (int.parse(valuesList[i])) {
        case 0:
          repeatDays += 'SA';
          break;
        case 1:
          repeatDays += 'SU';
          break;
        case 2:
          repeatDays += 'MO';
          break;
        case 3:
          repeatDays += 'TU';
          break;
        case 4:
          repeatDays += 'WE';
          break;
        case 5:
          repeatDays += 'TH';
          break;
        case 6:
          repeatDays += 'FR';
          break;
      }
    }

    return repeatDays;
  }
}
