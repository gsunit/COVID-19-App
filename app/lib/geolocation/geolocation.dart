import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationPage extends StatefulWidget {
  @override
  _GeolocationPageState createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  String _platformVersion = 'Unknown';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  GoogleMapController mapController;
  Coordinate currentLocationCoordinate;
  Position _currentLocation;
  Widget _mapChild;

  void _onMapCreated(GoogleMapController controller) {
    initPlatformState();
    print(_currentLocation);
    mapController = controller;
  }

  @override
  void initState() {
    _mapChild = Center(child: CircularProgressIndicator(),);
    getCurrentLocation();
    initPlatformState();
    super.initState();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }

  void getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      _currentLocation = res;
      _mapChild = mapWidget();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    print("Here");
    if (!mounted) return;
    Geofence.initialize();
    Geofence.startListening(GeolocationEvent.entry, (entry) {
      print("entry");
      scheduleNotification("Entry of a georegion", "Welcome to: ${entry.id}");
    });

    Geofence.startListening(GeolocationEvent.exit, (entry) {
      print("exit");
      scheduleNotification("Exit of a georegion", "Byebye to: ${entry.id}");
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[
                Text('Running on: $_platformVersion\n'),
                RaisedButton(
                  child: Text("Add region"),
                  onPressed: () {
                    Geolocation location = Geolocation(
                        latitude: 50.853410,
                        longitude: 3.354470,
                        radius: 50.0,
                        id: "Kerkplein13");
                    Geofence.addGeolocation(location, GeolocationEvent.entry)
                        .then((onValue) {
                      print("great success");
                      scheduleNotification(
                          "Georegion added", "Your geofence has been added!");
                    }).catchError((onError) {
                      print("great failure");
                    });
                  },
                ),
                RaisedButton(
                    child: Text("start listerning"),
                    onPressed: () {
                      Geofence.startListening(GeolocationEvent.entry, (entry) {
                        scheduleNotification(
                            "Entry of a georegion", "Welcome to: ${entry.id}");
                      });
                      Geofence.startListening(GeolocationEvent.exit, (exit) {
                        scheduleNotification(
                            "Exit of a georegion", "Welcome to: ${exit.id}");
                      });
                    }),
                RaisedButton(
                    child: Text("get user location"),
                    onPressed: () {
                      Geofence.getCurrentLocation().then((coordinate) {
                        print(
                            "great got latitude: ${coordinate.latitude} and longitude: ${coordinate.longitude}");
                      });
                    })
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: _mapChild,
          )
        ]),
      ),
    );
  }

  void scheduleNotification(String title, String subtitle) {
    Future.delayed(Duration(seconds: 5)).then((result) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          0, title, subtitle, platformChannelSpecifics,
          payload: 'item x');
    });
  }

  Widget mapWidget() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        zoom: 11.0,
      ),
      markers: _createMarker(),
    );
  }

  Set<Marker> _createMarker(){
    return <Marker>[
      Marker(
        markerId: MarkerId("home"),
        position: LatLng(_currentLocation.latitude,_currentLocation.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "home"),
      )
    ].toSet();
  }
}
