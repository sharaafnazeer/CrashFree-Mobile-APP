import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crash_free_mobile_app/api/DrivingApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location _location;
  Location get location => _location;
  LatLng _locationPosition;
  LatLng get locationPosition => _locationPosition;

  bool locationServiceActive = true;

  LocationProvider() {
    _location = new Location();
  }

  initialization(bool isDriving) async {
    debugPrint('Location ===>' + isDriving.toString());
    await getUserLocation(isDriving);
  }

  getUserLocation(bool isDriving) async {
    bool _serviceEnabled = false;

    PermissionStatus _permissionGranted;

    // ignore: unnecessary_statements
    _serviceEnabled == await location.serviceEnabled() || false;

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if(!_serviceEnabled) {
        return;
      }
    }
    
    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      
      if(_permissionGranted == PermissionStatus.GRANTED) {
        return;
      }
    }
    
    location.onLocationChanged().listen((LocationData currentLocation) async {
      _locationPosition = LatLng(currentLocation.latitude, currentLocation.longitude);

      debugPrint('Location inside ===' + isDriving.toString());
      if(isDriving) {
        await updateDrivingLocation(locationPosition.latitude, locationPosition.longitude, isDriving)
            .then((value) => {});
      }
    });

    notifyListeners();
  }
}