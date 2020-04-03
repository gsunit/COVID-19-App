import 'dart:async';

import 'package:covid_19_app/covid_visualizer/covid_visualizer_page.dart';
import 'package:covid_19_app/feed/feed_page.dart';
import 'package:covid_19_app/fonts/globe_icon.dart';
import 'package:covid_19_app/fonts/twitter_icon.dart';
import 'package:covid_19_app/geolocation/geolocation.dart';
import 'package:covid_19_app/home/home_links.dart';
import 'package:covid_19_app/home/home_tab.dart';
import 'package:covid_19_app/home/reverse_countdown.dart';
import 'package:covid_19_app/models/user_model.dart';
import 'package:covid_19_app/notifications/notif_drawer.dart';
import 'package:covid_19_app/payments/payments_page.dart';
import 'package:covid_19_app/webview_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    @required this.title,
    @required this.user,
  }) : super(key: key);

  final String title;
  final UserModel user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void _showDialog(Map<String, dynamic> message) {
    //print(message['notification']['content']);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message['notification']['title']),
            content: new Text(message['notification']['body']),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text("Close"))
            ],
          );
        });
  }

  Future<void> dailyNotifications() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(0, 'Alert!',
        'Time to take Vitamin C!', time, platformChannelSpecifics);
  }

  /// Schedules a notification that specifies a different icon, sound and vibration pattern
  Future<void> _scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
//    var vibrationPattern = Int64List(4);
//    vibrationPattern[0] = 0;
//    vibrationPattern[1] = 1000;
//    vibrationPattern[2] = 5000;
//    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  void _initNotifications() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }

  void _initFirebaseCloudMessaging() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          _showDialog(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          _showDialog(message);
          //_navigateToItemDetail(message);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          _showDialog(message);
          //_navigateToItemDetail(message);
        },
        onBackgroundMessage: myBackgroundMessageHandler);
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
  }

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _initFirebaseCloudMessaging();
    dailyNotifications();
  }

  @override
  Widget build(BuildContext context) {

    print("db #46: hrs in home_page: ${widget.user.hrs}");

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotifDrawerPage()));
              })
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("COVID Visualizer"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CovidVisualizerPage()));
              },
            ),
            RaisedButton(
              child: Text("Guidelines"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebviewPage(
                              title: "WHO Guidelines",
                              url:
                                  'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/technical-guidance/guidance-for-schools-workplaces-institutions',
                            )));
              },
            ),
            RaisedButton(
              child: Text("Feed"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedPage()));
              },
            ),
            RaisedButton(
              child: Text("Payments"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentsPage()));
              },
            ),
            RaisedButton(
              child: Text("Geolocation"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GeolocationPage()));
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
              // UserStatusWidget(user: widget.user,),
              // SizedBox(height: 15.0),
              // // Text("Check the app regularly to determine if you are at risk.", style: TextStyle(),),
              // SizedBox(height: 15.0,),
              // Divider(
              //   color: Colors.grey,
              //   thickness: 1.5,
              // ),

              SizedBox(
                height: 10.0,
              ),
              Text(
                "Stay updated. Stay safe.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              HomeTab(
                title: "Latest Updates",
                icon: TwitterIcon.twitter,
                color: Colors.lightBlue,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedPage()));
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              HomeTab(
                title: "COVID-19 Statistics",
                icon: GlobeIcon.globe,
                color: Colors.lightGreen,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CovidVisualizerPage()));
                },
              ),
              SizedBox(
                height: 45.0,
              ),

              Text(
                "Did you take your Vitamin-C today?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              ReverseCountdown(
                user: widget.user,
                homeTitle: widget.title,
              ),
              RaisedButton(
                child: Text("Schedule a Notification"),
                onPressed: () async {
                  await _scheduleNotification();
                },
              ),
              SizedBox(
                height: 45.0,
              ),

              Image.asset("./assets/who.png"),
              // SizedBox(height: 25.0,),
              // Text("More information on COVID-19", style: TextStyle(fontSize: 16.0, color: Colors.black45)),
              // SizedBox(height: 10.0,),
              HomeLinks(
                title: "Infection prevention and control",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebviewPage(
                                title: "WHO Guidelines",
                                url:
                                    'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/technical-guidance/infection-prevention-and-control',
                              )));
                },
              ),
              HomeLinks(
                title: "Work from home guide",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebviewPage(
                              title: "Blogpost",
                              url:
                                  'https://blog.trello.com/work-from-home-guides')));
                },
              ),
              HomeLinks(
                title: "Reducing animal-human transmission",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebviewPage(
                              title: "WHO Guidelines",
                              url:
                                  'https://www.who.int/health-topics/coronavirus/who-recommendations-to-reduce-risk-of-transmission-of-emerging-pathogens-from-animals-to-humans-in-live-animal-markets')));
                },
              ),
              SizedBox(
                height: 45.0,
              ),

              Text(
                "Stretch out a helping hand",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Image.asset("./assets/pmcares.jpeg"),
                height: 250.0,
                alignment: Alignment.center,
              ),
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentsPage()));
                  },
                  child: Text("Donate to PM Cares Fund",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.lightGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
