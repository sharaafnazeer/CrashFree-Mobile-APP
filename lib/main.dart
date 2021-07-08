import 'package:crash_free_mobile_app/AccidentAlert.dart';
import 'package:crash_free_mobile_app/Login.dart';
import 'package:crash_free_mobile_app/Register.dart';
import 'package:crash_free_mobile_app/Splash.dart';
import 'package:crash_free_mobile_app/Welcome.dart';
import 'package:crash_free_mobile_app/driver/DriverHome.dart';
import 'package:crash_free_mobile_app/driver/DrowsyPage.dart';
import 'package:crash_free_mobile_app/util/LocationProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    Future<FirebaseApp> fbApp = Firebase.initializeApp();
    return OverlaySupport(child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LocationProvider(),
            child: DriverHome(),
          )
        ],
        child: FutureBuilder(
            future: fbApp,
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(child: Text('Something went wrong!'),);

              } else if (snap.hasData) {
                return MaterialApp(
                  initialRoute: '/',
                  routes: {
                    '/': (BuildContext context) => SplashScreenPage(),
                    '/welcome': (BuildContext context) => Welcome(),
                    '/register': (BuildContext context) => RegisterPage(),
                    '/login': (BuildContext context) => LoginPage(),
                    '/driverHome': (BuildContext context) => DriverHome(),
                    '/drowsy': (BuildContext context) => DrowsyPage(),
                  },
                  theme: ThemeData(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    primaryColor: Colors.red,
                    accentColor: Colors.red,
                    brightness: Brightness.dark,
                    textTheme: TextTheme(
                      headline1:
                          TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
                      headline5:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                      headline6:
                          TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                      bodyText1: TextStyle(fontSize: 20),
                      bodyText2: TextStyle(fontSize: 18),
                    ),
                  ),
                  title: 'Crash Free',
                  debugShowCheckedModeBanner: false,
                );
              }
              return Center(child: CircularProgressIndicator(),);
            })));
  }
}
