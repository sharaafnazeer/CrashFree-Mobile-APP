import 'dart:io';
import 'package:crash_free_mobile_app/models/ApiResponse.dart';
import 'package:crash_free_mobile_app/models/Auth.dart';
import 'package:crash_free_mobile_app/models/User.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Auth> login(String email, String password) async {

  final response =
      await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/login"), 
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password' : password
      }));

  if (response.statusCode == 200) {
    return Auth.fromJson(ApiResponse.fromJson(jsonDecode(response.body)).response);
  } else {
    throw Exception('Failed to login');
  }
}

Future<ApiResponse> register(User user) async {

  final response =
      await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/register"), 
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(user.toJson()));

  if (response.statusCode == 200) {
    debugPrint(response.body.toString());
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to register account');
  }
}

Future<String> verify() async {

  final userSession = await UserSession.getSession();
  final response =
      await http.get(new Uri.https("crash-free-backend.herokuapp.com", "/api/verify"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
      HttpHeaders.contentTypeHeader: 'application/json'},);

  if (response.statusCode == 200) {
    return 'SUCCESS';
  } else {
    throw Exception('Failed to load vehicles');
  }
}

Future<ApiResponse> updateToken(String token) async {
  final userSession = await UserSession.getSession();
  final response =
      await http.post(new Uri.https("crash-free-backend.herokuapp.com", "/api/fcm"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userSession,
                HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, String>{
        'token': token
      }));
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to save fcm token');
  }
}