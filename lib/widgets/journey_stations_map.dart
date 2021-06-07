import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:university_transportation_driver/modules/models/detailed_journey_station_model.dart';
import 'package:university_transportation_driver/utils/services/station/station_service.dart';
import 'package:university_transportation_driver/utils/services/station/station_service_web.dart';
import 'package:university_transportation_driver/widgets/loader.dart';

// ignore: must_be_immutable
class JourneyStationMap extends StatefulWidget {
  String journeyId;

  JourneyStationMap({Key key, this.journeyId}) : super(key: key);

  @override
  _JourneyStationMapState createState() => _JourneyStationMapState();
}

class _JourneyStationMapState extends State<JourneyStationMap> {
  final StationService _stationService = new StationServiceWeb();
  List<Marker> _markers = <Marker>[];
  LatLng _centerLocation = LatLng(0.0, 0.0);
  MapController _mapController;

  bool _isLoading = false;

  initWidgetProperties() async {
    _mapController = MapController();
    setState(() {
      _isLoading = true;
    });

    List<DetailedJourneyStationModel> stations =
        await _stationService.getStationsByJourneyIdAsync(widget.journeyId);

    setState(() {
      if (stations != null && stations.length > 0) {
        _centerLocation =
            LatLng(stations.first.latitude, stations.first.longitude);
        _mapController.move(_centerLocation, 14.0);

        for (var station in stations)
          _markers.add(Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(station.latitude, station.longitude),
            builder: (ctx) => Container(
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 35.0,
              ),
            ),
          ));
      }

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
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: _centerLocation,
            zoom: 14.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(markers: _markers),
          ],
        ),
        _isLoading ? Loader() : Stack(),
      ],
    );
  }
}
