import 'package:covid_19_app/feed/govt_updates_page.dart';
import 'package:covid_19_app/feed/news_feed_page.dart';
import 'package:covid_19_app/feed/tweets_feed_page.dart';
import 'package:covid_19_app/fonts/globe_icon.dart';
import 'package:covid_19_app/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
  

class CovidVisualizerPage extends StatefulWidget {
  @override
  _CovidVisualizerPageState createState() => _CovidVisualizerPageState();
}

class _CovidVisualizerPageState extends State<CovidVisualizerPage> {

  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: GlobeIcon.globe,
            title: "Global",
          ),
          TabData(
            iconData: Icons.home,
            title: "India",
          ),
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
  //   switch (page) {
  //     case 0:
  //       return WebviewPage(
  //         title: "Global Visualizer",
  //         url: 'https://www.covidvisualizer.com/',
  //       );
  //     case 1:
  //       return WebviewPage(
  //         title: "State Statistics",
  //         url: "https://www.covid19india.org/",
  //       );
  //     default:
  //       return WebviewPage(
  //         title: "Global Visualizer",
  //         url: 'https://www.covidvisualizer.com/',
  //       );
  //   }
    switch (page) {
      case 0:
        return WebviewPage(
          title: "Global Visualizer",
          url: 'https://www.covidvisualizer.com/',
        );
      case 1:
        return Container(
          child: WebviewPage(
            title: "State Statistics",
            url: "https://www.covid19india.org/",
          ),
        );
      case 2:
        return NewsFeedPage();
      case 3:
        return GovtUpdatesPage();
      default:
        return TweetsFeedPage();
    }
      
  }
  
}