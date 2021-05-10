import 'package:shared_preferences/shared_preferences.dart';

class UserSession {

  static Future<bool> userLoggedIn () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('token');
    return userId != null;

  }

  static void userLogout () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', null);
    prefs.setBool('verified', false);
  }

  static Future<String> getSession () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}