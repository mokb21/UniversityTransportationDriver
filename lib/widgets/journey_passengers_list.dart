import 'package:flutter/material.dart';
import 'package:university_transportation_driver/config/themes/theme_constants.dart';
import 'package:university_transportation_driver/modules/models/passenger_model.dart';
import 'package:university_transportation_driver/utils/services/trip/trip_service.dart';
import 'package:university_transportation_driver/utils/services/trip/trip_service_web.dart';
import 'package:university_transportation_driver/widgets/loader.dart';

// ignore: must_be_immutable
class JourneyPassengersList extends StatefulWidget {
  String journeyId;

  JourneyPassengersList({Key key, this.journeyId}) : super(key: key);

  @override
  _JourneyPassengersListState createState() => _JourneyPassengersListState();
}

class _JourneyPassengersListState extends State<JourneyPassengersList> {
  final TripService _tripService = new TripServiceWeb();
  List<PassengerModel> _passengers = <PassengerModel>[];

  bool _isLoading = false;

  initWidgetProperties() async {
    setState(() {
      _isLoading = true;
    });

    List<PassengerModel> passenger =
        await _tripService.getPassengers(widget.journeyId);

    setState(() {
      if (passenger != null) _passengers = passenger;
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
    return _passengers.isEmpty
        ? Center(
            child: Text("No Data Found"),
          )
        : Stack(
            children: [
              ListView.builder(
                itemCount: _passengers.length,
                itemBuilder: (BuildContext ctxt, int i) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: ThemeConstants.PrimaryColor,
                        size: 45.0,
                      ),
                      title: Text(_passengers[i].userName),
                      subtitle: Text(_passengers[i].universityId),
                    ),
                  );
                },
              ),
              _isLoading ? Loader() : Stack()
            ],
          );
  }
}
