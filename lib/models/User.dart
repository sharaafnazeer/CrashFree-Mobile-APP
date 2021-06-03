import 'package:flutter/foundation.dart';
class User {

  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  String address;

  User({this.firstName, this.lastName, this.email, this.phone, this.password, this.address});

  factory User.fromJson(json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address
    };
  }
}