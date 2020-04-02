import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class VideoModel {
  
  final String link;
  final String thumbnail;
  final Timestamp time;
  final String channel;
  final String title;

  VideoModel({
    @required this.link,
    @required this.thumbnail,
    @required this.time,
    @required this.channel,
    @required this.title
  });

}