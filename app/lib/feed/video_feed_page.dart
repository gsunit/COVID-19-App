import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:flutter/material.dart';

class VideoFeedPage extends StatefulWidget {
  @override
  _VideoFeedPageState createState() => _VideoFeedPageState();
}

class _VideoFeedPageState extends State<VideoFeedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Video Feed")
    );
  }
}