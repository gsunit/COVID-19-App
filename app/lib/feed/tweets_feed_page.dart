import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:flutter/material.dart';

class TweetsFeedPage extends StatefulWidget {
  @override
  _TweetsFeedPageState createState() => _TweetsFeedPageState();
}

class _TweetsFeedPageState extends State<TweetsFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Tweets")
    );
  }
}