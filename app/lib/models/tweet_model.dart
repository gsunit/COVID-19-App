import 'package:flutter/widgets.dart';

class TweetModel {
  
  final String tweet;
  final String handle;
  final String time;
  final String link;

  TweetModel({
    @required this.tweet,
    @required this.handle,
    @required this.time,
    @required this.link,
  });

}