import 'dart:developer';
import 'dart:io';
import 'package:crash_free_mobile_app/models/ApiResponse.dart';
import 'package:crash_free_mobile_app/models/Vehicle.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Vehicle>> fetchAllVehicles() async {

  final response =
      await http.get(new Uri.http("127.0.0.1:3000", "/api/vehicle"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA"},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<Vehicle> vehicles = List<Vehicle>.from(iterable.map((model)=> Vehicle.fromJson(model)));
    return vehicles;
  } else {
    throw Exception('Failed to load vehicles');
  }
}

Future<ApiResponse> saveVehicle(Vehicle vehicle) async {
  final response =
      await http.post(new Uri.http("127.0.0.1:3000", "/api/vehicle"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA",
                HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(vehicle.toJson()));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save vehicle');
  }
}

Future<ApiResponse> updateVehicle(Vehicle vehicle) async {

  final response =
      await http.put(new Uri.http("127.0.0.1:3000", "/api/vehicle/" + vehicle.id), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA",
      HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(vehicle.toJson()));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save vehicle');
  }
}

Future<ApiResponse> deleteVehicle(Vehicle vehicle) async {
  final response =
      await http.delete(new Uri.http("127.0.0.1:3000", "/api/vehicle/" + vehicle.id), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA",
      HttpHeaders.contentTypeHeader: 'application/json'},
      );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save vehicle');
  }
}