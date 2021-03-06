import 'package:flutter/material.dart';
import 'package:university_transportation_driver/constants/routing_constants.dart';
import 'package:university_transportation_driver/modules/screens/home_screen.dart';
import 'package:university_transportation_driver/modules/screens/journey_details_Screen.dart';
import 'package:university_transportation_driver/modules/screens/journeys_screen.dart';
import 'package:university_transportation_driver/modules/screens/login_screen.dart';
import 'package:university_transportation_driver/modules/screens/map_screen.dart';
import 'package:university_transportation_driver/modules/screens/profile_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutingConstants.HomeScreenRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case RoutingConstants.LoginScreenRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case RoutingConstants.MapScreenRoute:
      return MaterialPageRoute(builder: (context) => MapScreen());
    case RoutingConstants.JourneysScreenRoute:
      return MaterialPageRoute(builder: (context) => JourneysScreen());
    case RoutingConstants.ProfileScreenRoute:
      return MaterialPageRoute(builder: (context) => ProfileScreen());
    case RoutingConstants.JourneyDetailsScreenRoute:
      final arguments = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => JourneyDetailsScreen(journeyId: arguments));
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
