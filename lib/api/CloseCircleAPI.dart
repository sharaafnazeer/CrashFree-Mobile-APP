import 'dart:io';
import 'package:crash_free_mobile_app/models/ApiResponse.dart';
import 'package:crash_free_mobile_app/models/CloseCircleUser.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<CloseCircleUser>> fetchAllUsers() async {
  final userSession = await UserSession.getSession();
  final response =
      await http.get(new Uri.https("crash-free-backend.herokuapp.com", "/api/user"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<CloseCircleUser> closeCircles = List<CloseCircleUser>.from(iterable.map((model)=> CloseCircleUser.fromJson(model)));
    return closeCircles;
  } else {
    throw Exception('Failed to load close circles');
  }
}

Future<List<CloseCircleUser>> fetchAllAcceptedCircle() async {
  final userSession = await UserSession.getSession();
  final response =
      await http.get(new Uri.https("crash-free-backend.herokuapp.com", "/api/circle/get-approved"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<CloseCircleUser> closeCircles = List<CloseCircleUser>.from(iterable.map((model)=> CloseCircleUser.fromJson(model)));
    return closeCircles;
  } else {
    throw Exception('Failed to load close circles');
  }
}

Future<List<CloseCircleUser>> fetchAllPendingCircle() async {
  final userSession = await UserSession.getSession();
  final response =
      await http.get(new Uri.https("crash-free-backend.herokuapp.com", "/api/circle/get-pending"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<CloseCircleUser> closeCircles = List<CloseCircleUser>.from(iterable.map((model)=> CloseCircleUser.fromJson(model)));
    return closeCircles;
  } else {
    throw Exception('Failed to load close circles');
  }
}

Future<List<CloseCircleUser>> fetchAllRequestedCircle() async {
  final userSession = await UserSession.getSession();
  final response =
      await http.get(new Uri.https("crash-free-backend.herokuapp.com", "/api/circle/get-requested"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<CloseCircleUser> closeCircles = List<CloseCircleUser>.from(iterable.map((model)=> CloseCircleUser.fromJson(model)));
    return closeCircles;
  } else {
    throw Exception('Failed to load close circles');
  }
}

Future<ApiResponse> deleteCircleUser(CloseCircleUser circleUser) async {
  final userSession = await UserSession.getSession();
  final response =
      await http.delete(new Uri.https("crash-free-backend.herokuapp.com", "/api/circle/" + circleUser.id), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
      HttpHeaders.contentTypeHeader: 'application/json'},
      );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete circle');
  }
}

Future<ApiResponse> saveCircleUser(CloseCircleUser circleUser) async {
  final userSession = await UserSession.getSession();
  final response =
      await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/circle"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
      HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'circleUser': circleUser.circleUserId,
        'type': 0
      }
  ));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save circle');
  }
}

Future<ApiResponse> approveCircleUser(CloseCircleUser circleUser) async {
  final userSession = await UserSession.getSession();
  final response =
      await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/circle/approve"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
      HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'circleUser': circleUser.circleUserId
      }
  ));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to approve circle');
  }
}