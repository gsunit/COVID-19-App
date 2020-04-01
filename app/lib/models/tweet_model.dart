import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class TweetModel {
  
  final String tweet;
  final String handle;
  final Timestamp time;
  final String link;
  final String hashTag;

  TweetModel({
    @required this.tweet,
    @required this.handle,
    @required this.time,
    @required this.link,
    @required this.hashTag,
  });

}