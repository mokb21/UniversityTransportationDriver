import 'package:flutter/material.dart';
import 'package:university_transportation_driver/modules/models/journey_model.dart';
import 'package:university_transportation_driver/utils/services/journey/journey_service.dart';
import 'package:university_transportation_driver/utils/services/journey/journey_service_web.dart';
import 'package:university_transportation_driver/widgets/journey_basic_details.dart';
import 'package:university_transportation_driver/widgets/journey_passengers_list.dart';
import 'package:university_transportation_driver/widgets/journey_stations_list.dart';
import 'package:university_transportation_driver/widgets/journey_stations_map.dart';
import 'package:university_transportation_driver/widgets/loader.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class JourneyDetailsScreen extends StatefulWidget {
  final String journeyId;

  JourneyDetailsScreen({Key key, this.journeyId}) : super(key: key);

  @override
  _JourneyDetailsScreenState createState() => _JourneyDetailsScreenState();
}

class _JourneyDetailsScreenState extends State<JourneyDetailsScreen> {
  final JourneyService _journeyService = new JourneyServiceWeb();
  JourneyModel _journey = JourneyModel(
    name: '',
    repeatDays: '1,2,3,4,5,6,7',
    startDate: 'T',
    endDate: 'T',
    isStarted: false,
  );

  bool _isLoading = false;

  initWidgetProperties() async {
    setState(() {
      _isLoading = true;
    });

    var journey = await _journeyService.getJourneyByIdAsync(widget.journeyId);

    setState(() {
      _journey = journey;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initWidgetProperties();
  }

  Future<void> _scanQR() async {
    String cameraScanResult = await scanner.scan();
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      Tab(text: 'Basic'),
      Tab(text: 'Passengers'),
      Tab(text: 'Stations'),
      Tab(text: 'Map'),
    ];

    return DefaultTabController(
      length: _tabs.length,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('University Transportation Driver'),
              bottom: TabBar(
                tabs: _tabs,
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.qr_code_scanner_rounded),
                    tooltip: 'Scan QR',
                    onPressed: _scanQR),
              ],
            ),
            body:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              JourneyBasicDetails(journeyModel: this._journey),
              JourneyPassengersList(journeyId: this._journey.id),
              JourneyStationsList(journeyId: this._journey.id),
              JourneyStationMap(journeyId: this._journey.id),
            ]),
          ),
          _isLoading ? Loader() : Stack(),
        ],
      ),
    );
  }
}
