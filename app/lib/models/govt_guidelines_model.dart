import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class GovtGuidelinesModel {
  
  final String title;
  final String handle;
  final Timestamp time;
  final String link;

  GovtGuidelinesModel({
    @required this.title,
    @required this.handle,
    @required this.time,
    @required this.link,
  });

}