import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:flutter/material.dart';

class GovtUpdatesPage extends StatefulWidget {
  @override
  _GovtUpdatesPageState createState() => _GovtUpdatesPageState();
}

class _GovtUpdatesPageState extends State<GovtUpdatesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: "Govt. Updates",
      )
    );
  }
}