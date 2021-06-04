import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class UserSession {

  static Future<bool> userLoggedIn () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('token');
    return userId != null;

  }

  static void userLogout () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', null);
    prefs.setBool('verified', false);
  }

  static Future<String> getSession () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String> getUserId () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static void startStopDriving (bool isDriving) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('driving', isDriving);
  }

  static void setDrivingVehicle (String vehicleId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('vehicleId', vehicleId);
  }

  static Future<bool> isDriving () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('driving');
  }

  static Future<String> isDrivingVehicle () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('vehicleId');
  }

  static void setAccidentParameters (double accelerometerThreshold, int notifyTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('accelerometerThreshold', accelerometerThreshold);
    prefs.setInt('notifyTime', notifyTime);
  }

  static Future<double> getAccidentThreshold () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('accelerometerThreshold');
  }

  static Future<int> getNotifyTime () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('notifyTime');
  }
}