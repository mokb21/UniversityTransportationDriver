import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:university_transportation_driver/constants/api_path.dart';
import 'package:university_transportation_driver/modules/models/login_model_web.dart';
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _currentLocation;
  MapController _mapController;
  HubConnection _connection;
  LoginModelWeb _model;

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

  _assignHubFunction() {
    if (_connection.state == HubConnectionState.connected) {
      _connection.on('ShowPointsOnMap', (message) {
        if (message != null && message.length == 4) {
          if (_model.user.userName.toLowerCase() ==
              message[1].toString().toLowerCase()) {
            setState(() {
              _currentLocation = LatLng(message[2], message[3]);
            });
          }
        }
      });
    }
  }

  Future<void> _invokeHubSendLocation() async {
    if (_connection.state == HubConnectionState.connected) {
      Position currentPosition = await _determinePosition();
      if (Position != null)
        setState(() {
          _currentLocation =
              LatLng(currentPosition.latitude, currentPosition.longitude);
          _mapController.move(_currentLocation, 14.0);
        });

      await _connection.invoke('SendGPSPoint', args: [
        _model.user.id,
        currentPosition.latitude,
        currentPosition.longitude
      ]);
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

  Future<void> initWidgetProperties() async {
    _mapController = MapController();
    _currentLocation = LatLng(0.0, 0.0);
    _model = await SharedPreferencesHelper.getCurrentUser();

    _connectTrackingHub();
  }

  @override
  void initState() {
    super.initState();
    initWidgetProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _currentLocation,
          zoom: 14.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _currentLocation,
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.directions_bus_rounded,
                    color: Colors.red,
                    size: 35.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _invokeHubSendLocation,
        tooltip: 'Send Location',
        child: Icon(Icons.location_on),
      ),
    );
  }
}
