import 'package:crash_free_mobile_app/api/DrivingApi.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrowsyPage extends StatefulWidget {
  @override
  DrowsyPageState createState() => new DrowsyPageState();
}

class DrowsyPageState extends State<DrowsyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isButtonVisible = true;

  @override
  void initState() {
    super.initState();

    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 1.0, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
  }

  void onEnd() {

    updateDriverDrowsy(false).then((value) =>
    {
        FlutterRingtonePlayer.stop(),
        isButtonVisible = false,
        Navigator.pop(context)
    });

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
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 24, 10, 10),
                    child: new Image.asset(
                      'images/sleepy.png',
                      height: 200.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('You seems drowsy!',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "We suspect that you are not okay to perform driving. Are you okay?",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                                child: Text('CONTINUE DRIVING'),
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
