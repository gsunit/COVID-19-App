import 'package:flutter/material.dart';

Widget customAppbar({String title, List<Widget> actions, Color color, double elevation, Color textColor}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: (textColor == null ? Colors.blue : textColor),
      ),
    ),
    elevation: (elevation == null ? 0.0 : elevation),
    backgroundColor: (color == null ? Colors.white : color),
    iconTheme: IconThemeData(color: Colors.blue),
  );
}