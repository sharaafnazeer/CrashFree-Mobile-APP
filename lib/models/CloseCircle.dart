import 'package:flutter/foundation.dart';

class CloseCircle {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int status;

  CloseCircle({@required this.id, @required this.firstName, @required this.lastName, @required this.email, @required this.status});

  factory CloseCircle.fromJson(json) {
    return CloseCircle(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      status: json['status'],
    );
  }
}