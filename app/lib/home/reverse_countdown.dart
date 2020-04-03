import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_app/home/home_page.dart';
import 'package:covid_19_app/models/user_model.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class ReverseCountdown extends StatefulWidget {
  ReverseCountdown({
    @required this.homeTitle,
    @required this.user,
  });

  final String homeTitle;
  final UserModel user;

  @override
  _ReverseCountdownState createState() => _ReverseCountdownState();
}

class _ReverseCountdownState extends State<ReverseCountdown> {
  final amtController = TextEditingController();

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

  Future<void> showPeriodicNotifications(
      int hour, int minute, int second) async {
    var time = Time(hour, minute, second);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0, 'Alert!', 'Time to Take Vitamin C!', time, platformChannelSpecifics);
  }

  @override
  void initState() {
    super.initState();
    amtController.text = widget.user.hrs.toString();
    _initNotifications();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    amtController.dispose();
    super.dispose();
  }

  final bool debugMode = true;

  DateTime now = DateTime.now();

  DateTime dDay = DateTime(2018, 11, 26, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    print("db #45: hrs in rev_countdown: ${widget.user.hrs}");
    dDay = _setDDay(widget.user.hrs, now);

    Duration _duration = dDay.difference(now);

    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "Next reminder in:",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 10.0,
          ),
          FlipClock.reverseCountdown(
            duration: _duration,
            digitColor: Colors.white,
            backgroundColor: Colors.black,
            digitSize: 30.0,
            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
            //onDone: () => print('ih'),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButtons(),
              _buildInputForm(),
            ],
          ),
        ],
      ),
    );
  }

  _buildButtons() {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () async {
            _checkValidation(context);
          },
          child: Text("Remind me daily at (hrs)",
              style: TextStyle(color: Colors.white)),
          color: Colors.lightGreen,
        ),
        RaisedButton(
          onPressed: () {},
          child: Text("Info", style: TextStyle(color: Colors.white)),
          color: Colors.lightBlue,
        ),
      ],
    );
  }

  _buildInputForm() {
    return Container(
      width: 50.0,
      child: TextFormField(
        controller: amtController,
        decoration: InputDecoration(
          // labelText: 'Time',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }

  void _checkValidation(BuildContext context) async {
    if (amtController.text == "") {
      final snackBar = SnackBar(
        content: Text('Please enter the time'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    else if(int.parse(amtController.text) > 23) {
      final snackBar = SnackBar(
        content: Text('Please enter a number between 0 and 23'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    int scheduledHour = now.hour + int.parse(amtController.text);

    int scheduledMinute = now.minute;

    int scheduledSecond = now.second;

    showPeriodicNotifications(scheduledHour, scheduledMinute, scheduledSecond);

    // _duration = dDay.difference(now);
    // _transaction = initiateTransaction(appName, amtController.text);
    final snackBar = SnackBar(
      content: Text('Setting reminder for ${amtController.text}:00 hrs'),
    );
    Scaffold.of(context).showSnackBar(snackBar);

    Firestore.instance.collection('users').document(widget.user.email).updateData({
      'hrs': amtController.text
    }).catchError((e){print("e #60: $e");});
    var userSnapshot = await Firestore.instance.collection('users').document(widget.user.email).get()
      .catchError((e){print("e #61: $e");});
    UserModel userModel = widget.user;
    userModel.visits = userSnapshot.data['visits'];
    userModel.hrs = int.parse(userSnapshot.data['hrs']);

    Scaffold.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(
      title: widget.homeTitle,
      user: userModel,
    )));
  }

  _setDDay(int hrs, DateTime now) {
    if (hrs > now.hour) {
      return DateTime(now.year, now.month, now.day, hrs, 0, 0);
    } else {
      return DateTime(now.year, now.month, now.day + 1, hrs, 0, 0);
    }
  }
}
