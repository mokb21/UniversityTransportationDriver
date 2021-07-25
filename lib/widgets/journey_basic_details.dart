import 'package:flutter/material.dart';
import 'package:university_transportation_driver/config/themes/theme_constants.dart';
import 'package:university_transportation_driver/modules/models/journey_model.dart';

// ignore: must_be_immutable
class JourneyBasicDetails extends StatefulWidget {
  JourneyModel journeyModel;
  JourneyBasicDetails({Key key, this.journeyModel}) : super(key: key);

  @override
  _JourneyBasicDetailsState createState() => _JourneyBasicDetailsState();
}

class _JourneyBasicDetailsState extends State<JourneyBasicDetails> {
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
                        getJourneyRepeatDays(widget.journeyModel.repeatDays),
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
                    onPressed: () {
                      setState(() {
                        widget.journeyModel.isStarted =
                            !widget.journeyModel.isStarted;
                      });
                    },
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

  String getJourneyRepeatDays(String value) {
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
