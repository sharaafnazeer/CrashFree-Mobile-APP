import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crash_free_mobile_app/api/DrivingApi.dart';
import 'package:crash_free_mobile_app/api/VehicleApi.dart';
import 'package:crash_free_mobile_app/driver/SuspiciousPage.dart';
import 'package:crash_free_mobile_app/models/Vehicle.dart';
import 'package:crash_free_mobile_app/util/LocationProvider.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isDriving = false;
  String vehicleId;
  String userId = 'NOID';
  int notifyTime = 50;
  Future<List<Vehicle>> futureAllVehicles;

  @override
  void initState() {
    super.initState();
    futureAllVehicles = fetchAllVehicles();
    _isDriving();
    Provider.of<LocationProvider>(context, listen: false)
        .initialization();
  }

  _isDriving() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDriving = (prefs.getBool('driving') ?? false);
      vehicleId = (prefs.getString('vehicleId') ?? null);
      userId = prefs.getString('userId');
      notifyTime = prefs.getInt('notifyTime');
    });

    debugPrint('Driving Started!! =====> ' + userId.toString());
    debugPrint('Driving Started!! =====> ' + vehicleId.toString());
  }

  Widget userTrackingData() {
    debugPrint("UserId =======>>>> " + userId);
    FirebaseFirestore.instance
        .collection('settings')
        .doc('accident')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        UserSession.setAccidentParameters(
            double.parse(
                documentSnapshot.get('accelerometerThreshold').toString()),
            documentSnapshot.get('notifyTime'));
      }
    });

    return new StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usertracking')
            .doc(userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          debugPrint(userDocument.data().toString());
          if (isDriving && userDocument['suspecious'] && !userDocument['accidentOccured']) {
            Future.delayed(const Duration(milliseconds: 1000), () {


              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuspiciousPage(notifyTime)));
            });
          }

          if (isDriving &&  userDocument['isDrowsy'] && !userDocument['suspecious']
              && !userDocument['accidentOccured']) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.of(context).pushNamed('/drowsy');
            });
          }

          return new Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Driving Statistics'),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vibration'),
                        Text(userDocument['vibrationValue'].toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Initial Pitch'),
                        Text(userDocument['pitchValueInitial']
                            .toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Initial Roll'),
                        Text(userDocument['rollValueInitial']
                            .toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Actual Pitch'),
                        Text(userDocument['pitchValue']
                            .toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Actual Roll'),
                        Text(userDocument['rollValue']
                            .toString()),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Center(
                      child: Text(
                        "We advise you not to close this page while driving!",
                        textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12)
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    userDocument['suspecious']
                        ? Text('Suspicious Activity Detected')
                        : Text('Drive Safely!'),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(8.0), child: location());
  }

  Widget location() {
    return Consumer<LocationProvider>(
      builder: (consumerContext, model, child) {
        return Column(children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: new Image.asset(
                'images/img.png',
                height: 150.0,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24.0, 0, 24, 4),
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    // return: show loading widget
                    return Center(
                      child: Text("Loading"),
                    );
                  }
                  if (snapshot.hasError) {
                    // return: show error widget
                    return Center(
                      child: ErrorWidget(snapshot.error),
                    );
                  }
                  List<Vehicle> vehicles = snapshot.data ?? [];
                  debugPrint(vehicles.map((e) => e.id.toString()).toString());
                  return DropdownButton(
                      hint: Text("Select"),
                      value: vehicleId,
                      isExpanded: true,
                      items: vehicles
                          .map((fc) => DropdownMenuItem<String>(
                                child: new Text(fc.model + " ==> " + fc.vehicleNo,
                                    style: new TextStyle(color: Colors.white)),
                                value: fc.id,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          debugPrint(value);
                          vehicleId = value;
                        });
                      });
                },
                future: futureAllVehicles,
              ),
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {


                            debugPrint('Initial ===>' + isDriving.toString());
                            isDriving = !isDriving;
                            debugPrint('Second ===>' + isDriving.toString());
                            UserSession.startStopDriving(isDriving);
                            UserSession.setDrivingVehicle(vehicleId);
                            debugPrint(
                                'Session Started ===>' + isDriving.toString());

                            _isDriving();

                            // if(!isDriving) {
                            //   Provider.of<LocationProvider>(context, listen: false).dispose();
                            // } else {
                            //   Provider.of<LocationProvider>(context, listen: false).resume();
                            // }

                            //Provider.of<LocationProvider>(context, listen: false).initialization(isDriving);
                            await startStopDriving(
                                    vehicleId,
                                    isDriving,
                                    model.locationPosition.latitude,
                                    model.locationPosition.longitude)
                                .then((value) => {});
                          },
                          child: Text(isDriving == true
                              ? "STOP DRIVING"
                              : "START DRIVING"),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        isDriving ? userTrackingData() : Row()
                      ],
                    )))
          ]);

        // return Container(
        //     child: Center(
        //   child: Text("Home Loading"),
        // ));
      },
    );
  }

  @override
  void dispose() {
    // Provider.of<LocationProvider>(context, listen: false).dispose();
    super.dispose();
  }
}
