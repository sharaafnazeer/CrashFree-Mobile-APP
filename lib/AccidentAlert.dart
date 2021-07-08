import 'package:crash_free_mobile_app/models/PushNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class AccidentAlert extends StatefulWidget {
  final PushNotification notification;
  AccidentAlert(this.notification);
  @override
  AccidentAlertState createState() => new AccidentAlertState();
}

class AccidentAlertState extends State<AccidentAlert> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isButtonVisible = true;

  @override
  void initState() {
    super.initState();
    // FlutterRingtonePlayer.play(
    //   android: AndroidSounds.notification,
    //   ios: IosSounds.glass,
    //   looping: true, // Android only - API >= 28
    //   volume: 1.0, // Android only - API >= 28
    //   asAlarm: false, // Android only - all APIs
    // );
  }

  void onEnd() {
    FlutterRingtonePlayer.stop();
    isButtonVisible = false;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
            key: _scaffoldKey,
            body: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [                  
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Text(
                      "We suspect that one of your family or fried is under danger. Please kindly check whether he/she is okay at the moment",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name'),
                        Text('Vibration'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Circle Type'),
                        Text('Vibration'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vehicle'),
                        Text('Vibration'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Actual Pitch'),
                        Text('Vibration'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Actual Roll'),
                        Text('Vibration'),
                      ],
                    ),]
                  ),
                  ),
                  isButtonVisible ?
                  ConstrainedBox(
                      constraints:
                      const BoxConstraints(minWidth: double.infinity),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  onEnd();
                                },
                                child: Text('CHECK MAP'),
                              ),
                            ],
                          ))) : Row()
                ],
              ),
            )),
        onWillPop: () async => false);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
