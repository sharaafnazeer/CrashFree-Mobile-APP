import 'package:crash_free_mobile_app/AccidentAlert.dart';
import 'package:crash_free_mobile_app/api/AuthAPI.dart';
import 'package:crash_free_mobile_app/api/CloseCircleAPI.dart';
import 'package:crash_free_mobile_app/api/VehicleApi.dart';
import 'package:crash_free_mobile_app/models/CloseCircleUser.dart';
import 'package:crash_free_mobile_app/models/PushNotification.dart';
import 'package:crash_free_mobile_app/models/Vehicle.dart';
import 'package:crash_free_mobile_app/util/UserSession.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'CloseCircle.dart';
import 'Home.dart';
import 'MyVehicle.dart';
import 'Profile.dart';
import 'closeCircle/CircleView.dart';
import 'myVehicle/AddEditVehicle.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Background service handler");
  print("Handling a background message: ${message.messageId}");
}

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  await updateToken(token).then((value) => {
    debugPrint(value.toString())
  });
}

class DriverHome extends StatefulWidget {
  @override
  DriverHomeState createState() => DriverHomeState();
}

class DriverHomeState extends State<DriverHome> {
  Future<List<CloseCircleUser>> futureAllUsers;
  Future<List<Vehicle>> futureVehicles;
  int _selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    CloseCirclePage(),
    VehiclePage(),
    ProfilePage(),
  ];
  FirebaseMessaging _messaging;
  PushNotification _notificationInfo;

  @override
  void initState() {

    FirebaseMessaging.instance.getToken().then((value) => {
      saveTokenToDatabase(value)
    });  

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase); 

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Clicked Message");
      
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      setState(() {
        _notificationInfo = notification;
      });

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccidentAlert(notification)));
      
    });
    checkForInitialMessage();
    super.initState();
    futureAllUsers = fetchAllUsers();
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      debugPrint("Notification Body ");
      setState(() {
        _notificationInfo = notification;
      });
    }
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        setState(() {
          _notificationInfo = notification;
        });

        if (notification != null) {
        // For displaying the notification as an overlay
        showSimpleNotification(
            Text(_notificationInfo.title),
            leading: null,
            subtitle: Text(_notificationInfo.body),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('CrashFree'),
          actions: (_selectedPage == 1)
              ? <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
                      showSearch(
                          context: context, delegate: Search(futureAllUsers));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
                      showLogoutAlertDialog(context);
                    },
                  ),
                ]
              : (_selectedPage == 2)
                  ? <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // do something
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => AddEditVehiclePage(vehicle: new Vehicle(vehicleNo: '', brand: '', model: '', type: '', status: 0)),
                          //   ));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditVehiclePage(
                                  vehicle: new Vehicle(
                                      vehicleNo: '',
                                      brand: '',
                                      model: '',
                                      type: '',
                                      status: 0)),
                            ),
                          ).then((value) {
                            setState(() {
                              futureVehicles = fetchAllVehicles();
                            });
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // do something
                          showLogoutAlertDialog(context);
                        },
                      ),
                    ]
                  : <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // do something
                          showLogoutAlertDialog(context);
                        },
                      ),
                    ]),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: 'Close Circle'),
          BottomNavigationBarItem(
              icon: Icon(Icons.commute), label: 'My Vehicles'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile')
        ],
      ),
    );
  }

  showLogoutAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Logout"),
      onPressed: () {
        UserSession.userLogout();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.popAndPushNamed(context, '/');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout from CrashFree"),
      content: Text(
          "You will be missing notifications. Would you like to continue?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class Search extends SearchDelegate {
  String selectedResult = '';
  final Future<List<CloseCircleUser>> closeCircleList;

  Search(this.closeCircleList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult == null || selectedResult.isEmpty
            ? selectedResult
            : 'Empty'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CloseCircleUser> suggestionList = [];

    return FutureBuilder<List<CloseCircleUser>>(
        future: closeCircleList,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            // return: show error widget
            return Center(
              child: ErrorWidget(snapshot.error),
            );
          }
          List<CloseCircleUser> users = snapshot.data ?? [];
          query.isEmpty
              ? suggestionList = []
              : suggestionList.addAll(users.where((user) =>
                  user.circleUserName
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  user.circleUserEmail
                      .toLowerCase()
                      .contains(query.toLowerCase())));

          return ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CircleViewPage(
                                closeCircleUser: suggestionList[index],
                              ))).then((value) {
                    // setState(() {
                    //   futureAllPendingCircle = fetchAllPendingCircle();
                    // });
                  });
                },
                child: Container(
                    child: new Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            child: Text(
                              suggestionList[index].circleUserName,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                          ),
                          new GestureDetector(
                              onTap: () {},
                              child: new Container(
                                margin: const EdgeInsets.all(0.0),
                                child: suggestionList[index].status == 1
                                    ? new Icon(
                                        Icons.people,
                                        color: Colors.blue,
                                        size: 24.0,
                                      )
                                    : suggestionList[index].status == 2
                                        ? new Icon(
                                            Icons.file_upload,
                                            color: Colors.grey,
                                            size: 24.0,
                                          )
                                        : new Icon(
                                            Icons.person_add,
                                            color: Colors.green,
                                            size: 24.0,
                                          ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
                      child: Container(
                        height: 1.0,
                      ),
                    ),
                  ],
                )),
              );
            },
          );
        });
  }
}
