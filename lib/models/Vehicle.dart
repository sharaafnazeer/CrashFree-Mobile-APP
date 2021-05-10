import 'package:flutter/foundation.dart';

class Vehicle {
  String id;
  String vehicleNo;
  String brand;
  String model;
  String type;
  int status;
  String user;

  Vehicle({this.id, @required this.vehicleNo, @required this.brand, @required this.model, 
  @required this.type, @required this.status, this.user});

  factory Vehicle.fromJson(json) {
    return Vehicle(
      id: json['_id'],
      vehicleNo: json['vehicleNo'],
      brand: json['brand'],
      model: json['model'],
      type: json['type'],
      status: json['status'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'vehicleNo': vehicleNo,
      'brand': brand,
      'model': model,
      'type': type,
      'status': status
    };
  }
}