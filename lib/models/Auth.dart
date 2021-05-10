import 'package:flutter/foundation.dart';

class Auth {
  final bool verified;
  final String token;

  Auth({@required this.verified, @required this.token});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      verified: json['verified'],
      token: json['token'],
    );
  }
}