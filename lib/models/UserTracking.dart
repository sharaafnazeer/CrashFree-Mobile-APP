class UserTracking {
  final bool userId;
  final String vehicleId;
  final bool accidentOccured;
  final bool suspecious;
  final DateTime time;
  final double vibrationValue;
  final double accelerometerValue;

  UserTracking({this.userId, this.vehicleId, this.accidentOccured, this.suspecious, this.time, this.vibrationValue, this.accelerometerValue});

  factory UserTracking.fromJson(json) {
    return UserTracking(
      userId: json['userId'],
      vehicleId: json['vehicleId'],
      accidentOccured: json['accidentOccured'],
      suspecious: json['suspecious'],
      time: json['time'],
      vibrationValue: json['vibrationValue'],
      accelerometerValue: json['accelerometerValue'],
    );
  }
}