import 'package:crash_free_mobile_app/Welcome.dart';
import 'package:crash_free_mobile_app/api/AuthAPI.dart';
import 'package:crash_free_mobile_app/driver/DriverHome.dart';
import 'package:crash_free_mobile_app/util/RouteGenerator.dart';
import 'package:crash_free_mobile_app/widgets/CustomButton.dart';
import 'package:crash_free_mobile_app/widgets/HeroImage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'driver/myVehicle/AddEditVehicle.dart';
import 'models/User.dart';

class RegisterPage  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  String email, password;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNoController.dispose();
    addressController.dispose();
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
              height:  MediaQuery.of(context).size.height * 0.15,
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
                          labelText: 'Frist Name',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        controller: firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                       SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
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
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        controller: phoneNoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
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

                      SizedBox(height: 20,),
                      
                      CustomButton(buttonText: 'Register', onBtnPressed: () async {
                        if (_formKey.currentState.validate()) {

                          var email = emailController.text;
                          var password = passwordController.text;
                          var firstName = firstNameController.text;
                          var lastName = lastNameController.text;
                          var address = addressController.text;
                          var phoneNumber = phoneNoController.text;

                          showLoaderDialog(context);

                          var user = new User();
                          user.firstName = firstName;
                          user.lastName = lastName;
                          user.email = email;
                          user.phone = phoneNumber;
                          user.password = password;
                          user.address = address;

                          await register(user).then((value) => {
                            
                              print(value.token),
                              saveCredentials(value.token, value.verified)
                              ,Navigator.of(context).pushNamedAndRemoveUntil(
                                RouteGenerator.driverMain,
                                (Route<dynamic> route) => false
                              )
                            });   
                            
                        }
                      },),
                      SizedBox(height: 10,),
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