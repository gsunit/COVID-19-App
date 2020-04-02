import 'package:covid_19_app/covid_visualizer/covid_visualizer_page.dart';
import 'package:covid_19_app/feed/feed_page.dart';
import 'package:covid_19_app/guidelines/guidelines_page.dart';
import 'package:covid_19_app/home/home_tab.dart';
import 'package:covid_19_app/home/user_status_widget.dart';
import 'package:covid_19_app/models/user_model.dart';
import 'package:covid_19_app/payments/payments_page.dart';
import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:covid_19_app/geolocation/geolocation.dart';
import 'package:covid_19_app/util/custom_icons.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    @required this.title,
    @required this.user
  }) : super(key: key);

  final String title;
  final UserModel user;

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserStatusWidget(user: widget.user,),
              SizedBox(height: 15.0),
              Text("Check the app regularly to determine if you are at risk.", style: TextStyle(),),
              SizedBox(height: 15.0,),
              Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              SizedBox(height: 10.0,),
              Text("Stay updated. Stay safe.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
              SizedBox(height: 10.0,),
              HomeTab(
                title: "Latest Updates",
                icon: CustomIcons.twitter,
                color: Colors.lightBlue,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeedPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
