import 'package:flutter/foundation.dart';

class Auth {
  final bool verified;
  final String token;
  final String id;

  Auth({@required this.verified, @required this.token, @required this.id});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      verified: json['verified'],
      token: json['token'],
      id: json['id'],
    );
  }
}