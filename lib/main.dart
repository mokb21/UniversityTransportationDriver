import 'package:flutter/material.dart';
import 'package:university_transportation_driver/constants/routing_constants.dart';
import 'package:university_transportation_driver/utils/helpers/router.dart'
    as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University Transportation Driver',
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutingConstants.LoginScreenRoute,
    );
  }
}
