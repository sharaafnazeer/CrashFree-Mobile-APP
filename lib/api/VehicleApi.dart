import 'dart:developer';
import 'dart:io';
import 'package:crash_free_mobile_app/models/ApiResponse.dart';
import 'package:crash_free_mobile_app/models/Vehicle.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Vehicle>> fetchAllVehicles() async {
  final userSession = await UserSession.getSession();
  final response =
      await http.get(new Uri.https("crash-free-backend.herokuapp.com", "/api/vehicle"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<Vehicle> vehicles = List<Vehicle>.from(iterable.map((model)=> Vehicle.fromJson(model)));
    return vehicles;
  } else {
    throw Exception('Failed to load vehicles');
  }
}

Future<ApiResponse> saveVehicle(Vehicle vehicle) async {
  final userSession = await UserSession.getSession();
  final response =
      await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/vehicle"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
                HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(vehicle.toJson()));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save vehicle');
  }
}

Future<ApiResponse> updateVehicle(Vehicle vehicle) async {
  final userSession = await UserSession.getSession();
  final response =
      await http.put(new Uri.https("crash-free-backend.herokuapp.com", "/api/vehicle/" + vehicle.id), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
      HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(vehicle.toJson()));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save vehicle');
  }
}

Future<ApiResponse> deleteVehicle(Vehicle vehicle) async {
  final userSession = await UserSession.getSession();
  final response =
      await http.delete(new Uri.https("crash-free-backend.herokuapp.com", "/api/vehicle/" + vehicle.id), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
      HttpHeaders.contentTypeHeader: 'application/json'},
      );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save vehicle');
  }
}