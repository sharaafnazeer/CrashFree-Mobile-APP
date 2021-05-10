import 'package:crash_free_mobile_app/Login.dart';
import 'package:crash_free_mobile_app/Register.dart';
import 'package:crash_free_mobile_app/Splash.dart';
import 'package:crash_free_mobile_app/Welcome.dart';
import 'package:crash_free_mobile_app/driver/DriverHome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',  
      routes: {
        '/': (BuildContext context) => SplashScreenPage(),
        '/welcome': (BuildContext context) => Welcome(),
        '/register': (BuildContext context) => RegisterPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/driverHome': (BuildContext context) => DriverHome(),
      },
      theme: ThemeData(

        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.red,
        accentColor: Colors.red,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          headline5: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 20),
          bodyText2: TextStyle(fontSize: 18),
        ),
      ),
      title: 'Crash Free',
      debugShowCheckedModeBanner: false,
    );
  }
}
