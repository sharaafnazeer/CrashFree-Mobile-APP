import 'package:crash_free_mobile_app/driver/DriverHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RouteGenerator {
  static const driverMain= "/driverHome";


  static Route<dynamic> generatorRoute(RouteSettings settings) {
  switch (settings.name) {

  case driverMain:
    return MaterialPageRoute(builder: (_) => DriverHome());
    break;

  }
 }
}