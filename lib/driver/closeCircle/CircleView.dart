import 'package:crash_free_mobile_app/api/CloseCircleAPI.dart';
import 'package:crash_free_mobile_app/driver/myVehicle/AddEditVehicle.dart';
import 'package:crash_free_mobile_app/models/ApiResponse.dart';
import 'package:crash_free_mobile_app/models/CloseCircleUser.dart';
import 'package:crash_free_mobile_app/util/toast.dart';
import 'package:flutter/material.dart';

class CircleViewPage extends StatelessWidget {

  final CloseCircleUser closeCircleUser;
  ApiResponse response;
  // receive data from the FirstScreen as a parameter
  CircleViewPage({Key key, this.closeCircleUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(closeCircleUser != null
              ? closeCircleUser.circleUserName
              : 'Annonymous User'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: new Image.asset(
                  'images/user.png',
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Container(
                        child: Text(
                          closeCircleUser.circleUserName,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)))),
                    new Container(
                        child: Text(
                          closeCircleUser.circleUserPhone,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0))))
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Container(
                        child: Text(
                          closeCircleUser.circleUserEmail,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)))),
                    new Container(
                        child: Text(
                          closeCircleUser.type,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0))))
                  ],
                ),
              ),


            ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child : Padding(
              padding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
              child: closeCircleUser.status == 1 ?  
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        showLoaderDialog(context);
                          await deleteCircleUser(closeCircleUser).then((value) => {
                              response = value,
                              showSuccess(response.response),
                              Navigator.of(context, rootNavigator: true).pop(),
                              Navigator.pop(context)
                          });
                      },
                      child: Text('REMOVE CIRCLE'),
                    ),
                ],
              ) :
              
              closeCircleUser.otherStatus == 1 ?               
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        showLoaderDialog(context);
                          await approveCircleUser(closeCircleUser).then((value) => {
                              response = value,
                              showSuccess(response.response),
                              Navigator.of(context, rootNavigator: true).pop(),
                              Navigator.pop(context)
                          });
                      },
                      child: Text('ACCEPT REQUEST'),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        showLoaderDialog(context);
                          await deleteCircleUser(closeCircleUser).then((value) => {
                              response = value,
                              showSuccess(response.response),
                              Navigator.of(context, rootNavigator: true).pop(),
                              Navigator.pop(context)
                          });
                      },
                      child: Text('DELETE REQUEST'),
                    ),                
                  ],
              ) : 

              closeCircleUser.otherStatus == 2 ? 

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        showLoaderDialog(context);
                          await deleteCircleUser(closeCircleUser).then((value) => {
                              response = value,
                              showSuccess(response.response),
                              Navigator.of(context, rootNavigator: true).pop(),
                              Navigator.pop(context)
                          });
                      },
                      child: Text('CANCEL REQUEST'),
                    ),
                    
                ],
              ) : 

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        showLoaderDialog(context);
                          await saveCircleUser(closeCircleUser).then((value) => {
                              response = value,
                              showSuccess(response.response),
                              Navigator.of(context, rootNavigator: true).pop(),
                              Navigator.pop(context)
                          });
                      },
                      child: Text('SEND REQUEST'),
                    ),
                    
                ],
              )             

            )
          )

              // Container(
              //   alignment: Alignment.bottomLeft,
              //   padding: EdgeInsets.only(top: 8),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       new Container(
              //           child: Text(
              //             closeCircleUser.circleUserEmail,
              //             textAlign: TextAlign.left,
              //             maxLines: 1,
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w400, fontSize: 16),
              //           ),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(10.0),
              //                   topRight: Radius.circular(10.0)))),
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }
}