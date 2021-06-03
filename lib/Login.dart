import 'package:crash_free_mobile_app/api/AuthAPI.dart';
import 'package:crash_free_mobile_app/util/RouteGenerator.dart';
import 'package:crash_free_mobile_app/widgets/CustomButton.dart';
import 'package:crash_free_mobile_app/widgets/HeroImage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'driver/myVehicle/AddEditVehicle.dart';

class LoginPage  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  String email, password;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          HeroImage(
              height:  MediaQuery.of(context).size.height * 0.5,
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if(!isValidEmail(value)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10,),

                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('New User?'),
                          MaterialButton(onPressed: () {
                            Navigator.restorablePushNamed(context, '/register');
                          }, child: Text('Sign Up',
                          style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      CustomButton(buttonText: 'Login', onBtnPressed: () async {
                        if (_formKey.currentState.validate()) {

                          var email = emailController.text;
                          var password = passwordController.text;
                          showLoaderDialog(context);
                          await login(email, password).then((value) => {
                              
                              print(value.token),
                              saveCredentials(value.token, value.verified)
                              ,Navigator.of(context).pushNamedAndRemoveUntil(
                                RouteGenerator.driverMain,
                                (Route<dynamic> route) => false
                              )
                            });   
                            
                        }
                      },)
                    ],
                  )
                  )
                )
              ],
              
            ))
        ],
      )
    );
  
  }

}

saveCredentials (String token, bool active) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setBool('verified', active);
}