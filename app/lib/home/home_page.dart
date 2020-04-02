import 'package:covid_19_app/covid_visualizer/covid_visualizer_page.dart';
import 'package:covid_19_app/feed/feed_page.dart';
import 'package:covid_19_app/fonts/globe_icon.dart';
import 'package:covid_19_app/fonts/india_icon.dart';
import 'package:covid_19_app/fonts/twitter_icon.dart';
import 'package:covid_19_app/home/home_links.dart';
import 'package:covid_19_app/home/home_tab.dart';
import 'package:covid_19_app/home/user_status_widget.dart';
import 'package:covid_19_app/models/user_model.dart';
import 'package:covid_19_app/payments/payments_page.dart';
import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:covid_19_app/geolocation/geolocation.dart';
import 'package:covid_19_app/webview_page.dart';
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
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  WebviewPage(
                  title: "WHO Guidelines",
                  url: 'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/technical-guidance/guidance-for-schools-workplaces-institutions',
                )));
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserStatusWidget(user: widget.user,),
              SizedBox(height: 15.0),
              // Text("Check the app regularly to determine if you are at risk.", style: TextStyle(),),
              SizedBox(height: 15.0,),
              Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              SizedBox(height: 10.0,),
              Text("Stay updated. Stay safe.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
              SizedBox(height: 15.0,),
              HomeTab(
                title: "Latest Updates",
                icon: TwitterIcon.twitter,
                color: Colors.lightBlue,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeedPage()));
                },
              ),
              SizedBox(height: 5.0,),
              HomeTab(
                title: "COVID-19 Statistics",
                icon: GlobeIcon.globe,
                color: Colors.lightGreen,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CovidVisualizerPage()));
                },
              ),
              SizedBox(height: 25.0,),
              Text("More information on COVID-19", style: TextStyle(fontSize: 16.0, color: Colors.black45)),
              SizedBox(height: 10.0,),
              HomeLinks(
                title: "Infection prevention and control",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewPage(
                    title: "WHO Guidelines",
                    url: 'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/technical-guidance/infection-prevention-and-control',
                  )));
                },
              ),
              HomeLinks(
                title: "Work from home guide",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewPage(
                    title: "Blogpost",
                    url: 'https://blog.trello.com/work-from-home-guides'
                  )));
                },
              ),
              HomeLinks(
                title: "Reducing animal-human transmission",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewPage(
                    title: "WHO Guidelines",
                    url: 'https://www.who.int/health-topics/coronavirus/who-recommendations-to-reduce-risk-of-transmission-of-emerging-pathogens-from-animals-to-humans-in-live-animal-markets'
                  )));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
