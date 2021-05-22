import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:university_transportation_driver/constants/api_path.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _latitude = 0.0;
  double _longitude = 0.0;

  HubConnection _connection;

  Future<void> _connectTrackingHub() async {
    _connection = HubConnectionBuilder()
        .withUrl(
            ApiPath.DomainURI + '/trackingHub',
            HttpConnectionOptions(
              client: IOClient(
                  HttpClient()..badCertificateCallback = (x, y, z) => true),
              logging: (level, message) => print(message),
            ))
        .build();

    await _connection.start();
    _assignHubFunction();
  }

  void _assignHubFunction() {
    if (_connection.state == HubConnectionState.connected)
      _connection.on('ShowPointsOnMap', (message) {
        if (message != null && message.length == 2) {
          setState(() {
            _latitude = message[0];
            _longitude = message[1];
          });
        }
      });
  }

  Future<void> _invokeHubSendLocation() async {
    if (_connection.state == HubConnectionState.connected) {
      Position currentPosition = await _determinePosition();
      await _connection.invoke('SendGPSPoint',
          args: [currentPosition.altitude, currentPosition.longitude]);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _connectTrackingHub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('University Transportation Driver'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sever Said:',
            ),
            Text(
              'latitude: $_latitude',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'longitude: $_longitude',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _invokeHubSendLocation,
        tooltip: 'Send Location',
        child: Icon(Icons.location_on),
      ),
    );
  }
}