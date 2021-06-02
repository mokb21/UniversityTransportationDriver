import 'package:flutter/material.dart';
import 'package:university_transportation_driver/constants/routing_constants.dart';
import 'package:university_transportation_driver/config/routes/router.dart'
    as router;
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool _isLoggedIn = await SharedPreferencesHelper.getIsLoggedIn();

  runApp(MyApp(_isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University Transportation Driver',
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: isLoggedIn
          ? RoutingConstants.HomeScreenRoute
          : RoutingConstants.LoginScreenRoute,
    );
  }
}
