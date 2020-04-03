import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:flutter/material.dart';

class NotifDrawerPage extends StatefulWidget {
  @override
  _NotifDrawerPageState createState() => _NotifDrawerPageState();
}

class _NotifDrawerPageState extends State<NotifDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(title: "Notifications"),
        body: Center(
          child: Text("No new notifications!"),
        ));
  }
}
