import 'dart:io';
import 'package:crash_free_mobile_app/models/ApiResponse.dart';
import 'package:crash_free_mobile_app/models/CloseCircle.dart';
import 'package:crash_free_mobile_app/models/CloseCircleUser.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<CloseCircleUser>> fetchAllUsers() async {
  final response =
      await http.get(new Uri.http("127.0.0.1:3000", "/api/user"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA"},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<CloseCircleUser> closeCircles = List<CloseCircleUser>.from(iterable.map((model)=> CloseCircleUser.fromJson(model)));
    return closeCircles;
  } else {
    throw Exception('Failed to load close circles');
  }
}

Future<List<CloseCircleUser>> fetchAllAcceptedCircle() async {
  final response =
      await http.get(new Uri.http("127.0.0.1:3000", "/api/circle/get-approved"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA"},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<CloseCircleUser> closeCircles = List<CloseCircleUser>.from(iterable.map((model)=> CloseCircleUser.fromJson(model)));
    return closeCircles;
  } else {
    throw Exception('Failed to load close circles');
  }
}

Future<List<CloseCircleUser>> fetchAllPendingCircle() async {
  final response =
      await http.get(new Uri.http("127.0.0.1:3000", "/api/circle/get-pending"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA"},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<CloseCircleUser> closeCircles = List<CloseCircleUser>.from(iterable.map((model)=> CloseCircleUser.fromJson(model)));
    return closeCircles;
  } else {
    throw Exception('Failed to load close circles');
  }
}

Future<List<CloseCircleUser>> fetchAllRequestedCircle() async {
  final response =
      await http.get(new Uri.http("127.0.0.1:3000", "/api/circle/get-requested"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA"},);

  if (response.statusCode == 200) {
    Iterable iterable = ApiResponse.fromJson(jsonDecode(response.body)).response;
    List<CloseCircleUser> closeCircles = List<CloseCircleUser>.from(iterable.map((model)=> CloseCircleUser.fromJson(model)));
    return closeCircles;
  } else {
    throw Exception('Failed to load close circles');
  }
}

Future<ApiResponse> deleteCircleUser(CloseCircleUser circleUser) async {
  final response =
      await http.delete(new Uri.http("127.0.0.1:3000", "/api/circle/" + circleUser.id), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA",
      HttpHeaders.contentTypeHeader: 'application/json'},
      );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to dekete circle');
  }
}

Future<ApiResponse> saveCircleUser(CloseCircleUser circleUser) async {
  final response =
      await http.post(new Uri.http("127.0.0.1:3000", "/api/circle"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA",
      HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'circleUser': circleUser.circleUserId,
        'type': 0
      }
  ));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to dekete circle');
  }
}

Future<ApiResponse> approveCircleUser(CloseCircleUser circleUser) async {
  final response =
      await http.post(new Uri.http("127.0.0.1:3000", "/api/circle/approve"), 
      headers: {HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Il9pZCI6IjYwNTFkY2RiYmJiMTUwMGZlMDE3NjkxMyIsImVtYWlsIjoic2hhcmFhZkBnbWFpbC5jb20ifSwiaWF0IjoxNjE2MDUzNzE1fQ.L0JdbnroCHnazsglFzMJyuVLG54-8XnWQlHNifE54vA",
      HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'circleUser': circleUser.circleUserId
      }
  ));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to dekete circle');
  }
}