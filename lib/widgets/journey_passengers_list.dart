import 'package:flutter/material.dart';
import 'package:university_transportation_driver/config/themes/theme_constants.dart';
import 'package:university_transportation_driver/modules/models/passenger_model.dart';
import 'package:university_transportation_driver/widgets/loader.dart';

// ignore: must_be_immutable
class JourneyPassengersList extends StatefulWidget {
  String journeyId;

  JourneyPassengersList({Key key, this.journeyId}) : super(key: key);

  @override
  _JourneyPassengersListState createState() => _JourneyPassengersListState();
}

class _JourneyPassengersListState extends State<JourneyPassengersList> {
  List<PassengerModel> _passengers = <PassengerModel>[];

  bool _isLoading = false;

  initWidgetProperties() async {
    setState(() {
      _isLoading = true;
    });

    List<PassengerModel> passenger = <PassengerModel>[
      PassengerModel(
          id: 'mokb',
          userName: 'mokb',
          email: 'mokb@mokb.mokb',
          phone: '+9631234567',
          qrCode: 'mokb',
          universityId: '201510022'),
      PassengerModel(
          id: 'Ahmed',
          userName: 'Ahmed',
          email: 'Ahmed@Ahmed.com',
          phone: '+9631234567',
          qrCode: 'Ahmed',
          universityId: '201710017'),
    ];

    setState(() {
      _passengers = passenger;
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
