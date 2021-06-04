import 'package:crash_free_mobile_app/api/VehicleApi.dart';
import 'package:crash_free_mobile_app/driver/myVehicle/AddEditVehicle.dart';
import 'package:crash_free_mobile_app/models/Vehicle.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class VehiclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehiclePageState();
  }
}

class VehiclePageState extends State<VehiclePage> {
  Future<List<Vehicle>> futureAllVehicles;

  @override
  void initState() {
    super.initState();
    futureAllVehicles = fetchAllVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
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
          List<Vehicle> vehicles = snapshot.data ?? [];

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddEditVehiclePage(vehicle: vehicles[index]),
                      ),
                    ).then((value) {
                      setState(() {
                        futureAllVehicles = fetchAllVehicles();
                      });
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Column(
                        children: <Widget>[
                          new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Container(
                                    child: Text(
                                      vehicles[index].brand +
                                          ' ' +
                                          vehicles[index].model,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0)))),
                                new Container(
                                    child: Text(
                                      vehicles[index].vehicleNo,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0))))
                              ]),
                          new Column(
                            children: [
                              new Container(
                                alignment: Alignment.centerRight,
                                child: vehicles[index].status == 1
                                    ? Badge(
                                        toAnimate: true,
                                        borderRadius: BorderRadius.circular(4),
                                        shape: BadgeShape.square,
                                        padding: EdgeInsets.all(4),
                                        badgeColor: Colors.green,
                                        badgeContent: Text('ACTIVE',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                      )
                                    : Badge(
                                        toAnimate: true,
                                        animationType: BadgeAnimationType.scale,
                                        borderRadius: BorderRadius.circular(4),
                                        shape: BadgeShape.square,
                                        padding: EdgeInsets.all(4),
                                        badgeColor: Colors.grey,
                                        badgeContent: Text('INACTIVE',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                      ),
                              )
                            ],
                          )
                        ],
                      )));
            },
          );
        },
        future: futureAllVehicles,
      ),
    );
  }
}
