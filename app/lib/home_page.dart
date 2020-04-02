import 'package:covid_19_app/covid_visualizer/covid_visualizer_page.dart';
import 'package:covid_19_app/feed/feed_page.dart';
import 'package:covid_19_app/guidelines/guidelines_page.dart';
import 'package:covid_19_app/payments/payments_page.dart';
import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:covid_19_app/geolocation/geolocation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      appBar: customAppbar(title: widget.title),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("COVID Visualizer"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CovidVisualizerPage()));
              },
            ),
            RaisedButton(
              child: Text("Guidelines"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  GuidelinesPage()));
              },
            ),
            RaisedButton(
              child: Text("Feed"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedPage()));
              },
            ),
            RaisedButton(
              child: Text("Payments"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentsPage()));
              },
            ),
            RaisedButton(
              child: Text("Geolocation"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => GeolocationPage()));
              },
            )
          ],
        ),
      ),
      body: Center(
        
      ),
    );
  }
}
