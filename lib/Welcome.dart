import 'package:crash_free_mobile_app/Login.dart';
import 'package:crash_free_mobile_app/widgets/CustomButton.dart';
import 'package:crash_free_mobile_app/widgets/HeroImage.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child:  HeroImage(
              height:  MediaQuery.of(context).size.height * 1,
            ),
          ),
          Positioned(
            bottom: 5,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              width:  MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Text('Welcome to CrashFree Application', style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: 20,),
                  CustomButton(buttonText : 'Getting Started', onBtnPressed : () {

                    Navigator.restorablePushNamed(context, '/login');

                    // Navigator.push( 
                    // context, 
                    // MaterialPageRoute( builder: (context) => LoginPage()));
                  })
                ],
              )
            ))
        ],
      )
    );
  
  }

}