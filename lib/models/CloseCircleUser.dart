import 'package:flutter/foundation.dart';

class CloseCircleUser {
  final String id;
  final String circleUserId;
  final String circleUserName;
  final String circleUserEmail;
  final String circleUserPhone;
  final int status;
  final String type;
  final int otherStatus; // 1 means came requests, 2 means sent requests
  final bool isCircle;

  CloseCircleUser({@required this.id, @required this.circleUserId, @required this.circleUserName, @required this.circleUserEmail, 
  @required this.circleUserPhone, @required this.status, @required this.type, @required this.otherStatus
  , @required this.isCircle});

  factory CloseCircleUser.fromJson(json) {
    return CloseCircleUser(
      id: json['_id'],
      circleUserId: json['circleUserId'],
      circleUserName: json['circleUserName'],
      circleUserEmail: json['circleUserEmail'],      
      circleUserPhone: json['circleUserPhone'],
      status: json['status'],
      type: json['type'],
      otherStatus: json['otherStatus'], 
      isCircle: json['isCircle']
    );
  }
}