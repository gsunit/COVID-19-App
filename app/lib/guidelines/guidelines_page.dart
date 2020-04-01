import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:flutter/material.dart';

class GuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Guidelines")
    );
  }
}