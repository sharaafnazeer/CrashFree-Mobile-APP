import 'dart:io';
import 'package:crash_free_mobile_app/models/ApiResponse.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<ApiResponse> startStopDriving(String vehicleId, bool driving, double lat, double long) async {
  debugPrint('Network call ===>' + driving.toString());
  final userSession = await UserSession.getSession();
  final response =
      await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/driving"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
      HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'vehicleId': vehicleId,
        'driving': driving,
        'lastLocation' : {
          'lat' : lat,
          'long': long
        }
      }));
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to do start stop driving');
  }
}

Future<ApiResponse> updateDrivingLocation(double lat, double long, bool isDriving) async {
  debugPrint('updating location ====' + isDriving.toString());
  final userSession = await UserSession.getSession();
  final response =
  await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/driving/location"),
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
        HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'lastLocation' : {
          'lat' : lat,
          'long': long
        }
      }));
  if (response.statusCode == 200) {
    debugPrint('updating location success');
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to do update location');
  }
}

Future<ApiResponse> updateDriverOkay(int status) async {
  final userSession = await UserSession.getSession();
  final response =
  await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/driver-update"),
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
        HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, int>{
        'status' : status
      }));
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to do update of driver');
  }
}