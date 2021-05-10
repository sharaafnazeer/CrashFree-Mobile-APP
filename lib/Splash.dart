
import 'package:crash_free_mobile_app/Welcome.dart';
import 'package:crash_free_mobile_app/api/AuthAPI.dart';
import 'package:crash_free_mobile_app/driver/DriverHome.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreenPage> {

  Future<Widget> loadFromFuture() async {    
    bool loggedIn = await UserSession.userLoggedIn();
    if (loggedIn) {      
      final String verified = await verify();

      if(verified == "SUCCESS") {
        return Future.value(new DriverHome());
      }      
       return Future.value(new Welcome());
    }
    return Future.value(new Welcome());
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(
      seconds: 5,
      navigateAfterFuture: loadFromFuture(),
      title: new Text('Welcome In SplashScreen',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red
    ),
    );
  }

}
