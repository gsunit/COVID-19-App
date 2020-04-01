import 'package:flutter/material.dart';

Widget customAppbar({String title, List<Widget> actions, Color color, double elevation}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Colors.blue),
    ),
    elevation: elevation,
    backgroundColor: (color == null ? Colors.white : color),
    iconTheme: IconThemeData(color: Colors.blue),
  );
}