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
                  child: Text(widget.journeyModel.repeatDays),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Text('Start: ' + widget.journeyModel.startDate),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Text('End: ' + widget.journeyModel.endDate),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
