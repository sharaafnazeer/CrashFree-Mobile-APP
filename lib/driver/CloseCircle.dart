import 'package:crash_free_mobile_app/driver/closeCircle/MyCircle.dart';
import 'package:crash_free_mobile_app/driver/closeCircle/Pending.dart';
import 'package:crash_free_mobile_app/driver/closeCircle/Requested.dart';
import 'package:flutter/material.dart';

class CloseCirclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CloseCirclePageState();
  }
}

class CloseCirclePageState extends State<CloseCirclePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: 'My Circle',),
                Tab(text: 'Pending',),
                Tab(text: 'Requested',),
              ],
            ),
          body: TabBarView(
            children: [
              MyCirclePage(),
              PendingPage(),
              RequestedPage(),
            ],
          ),
        ),
      ),
    );
  }
}