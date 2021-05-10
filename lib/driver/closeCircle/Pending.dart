import 'package:crash_free_mobile_app/api/CloseCircleAPI.dart';
import 'package:crash_free_mobile_app/models/CloseCircle.dart';
import 'package:crash_free_mobile_app/models/CloseCircleUser.dart';
import 'package:flutter/material.dart';

import 'CircleView.dart';

class PendingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PendingPageState();
  }
}

class PendingPageState extends State<PendingPage> {

  Future<List<CloseCircleUser>> futureAllPendingCircle;
  @override
  void initState() {
    super.initState();
    futureAllPendingCircle = fetchAllPendingCircle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError) {
            // return: show error widget
            return Center(
              child: ErrorWidget(snapshot.error),
            );
          }
          List<CloseCircleUser> closeCircles = snapshot.data ?? [];

          return ListView.builder(
            itemCount: closeCircles.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                onTap: () {
                  Navigator.push( 
                    context, 
                    MaterialPageRoute( builder: (context) => CircleViewPage(closeCircleUser: closeCircles[index],))).then((value) { 
                      setState(() {
                        futureAllPendingCircle = fetchAllPendingCircle();
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
                                    closeCircles[index].circleUserName,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                  ),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                                  )
                                ),
                                new Container(
                                    child: Text(
                                    closeCircles[index].circleUserPhone,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                                  )
                                )
                              ]
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Container(
                                    padding: EdgeInsets.only(
                                          left: 0, right: 0, top: 4),
                                    child: Text(
                                    closeCircles[index].circleUserEmail,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                                  )
                                ),
                                new Container(
                                    padding: EdgeInsets.only(
                                          left: 0, right: 0, top: 4),
                                    child: Text(
                                    closeCircles[index].type,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                                  )
                                )
                              ],
                            )
                          ],
                        )
                      )
              );
            },
          );
        },
        future: futureAllPendingCircle,
      ),
    );
  }
}