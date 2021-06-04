import 'package:crash_free_mobile_app/api/DrivingApi.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuspiciousPage extends StatefulWidget {
  @override
  SuspiciousPageState createState() => new SuspiciousPageState();
}

class SuspiciousPageState extends State<SuspiciousPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CountdownTimerController controller;
  int endTime = DateTime
      .now()
      .millisecondsSinceEpoch + 1000 * 10;
  bool isButtonVisible = true;

  @override
  void initState() {
    super.initState();
    getTimer();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    isButtonVisible = false;
    sendUpdate(2);
  }

  void sendUpdate(int status) {

    if(status == 2) {
      UserSession.startStopDriving(false);
    }

    updateDriverOkay(status).then((value) =>
    {
      controller.disposeTimer(),
      Navigator.pop(context),
    });
  }

  getTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint(prefs.getDouble('notifyTime').toString());
    setState(() {
      endTime = (int.parse(prefs.getDouble('notifyTime').toString()) ?? 15);
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
                      'images/img.png',
                      height: 200.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Are you okay?',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "We suspect a suspicious activity related to an accident. Are you really okay?",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: CountdownTimer(
                        controller: controller,
                        onEnd: onEnd,
                        endTime: endTime,
                        textStyle:
                        TextStyle(color: Colors.white, fontSize: 35)),
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
                                  sendUpdate(1);
                                },
                                child: Text('YES I AM OKAY'),
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
    controller.dispose();
    super.dispose();
  }
}
