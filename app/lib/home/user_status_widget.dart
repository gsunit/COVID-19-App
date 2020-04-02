import 'package:covid_19_app/models/user_model.dart';
import 'package:covid_19_app/util/app_colors.dart';
import 'package:flutter/material.dart';

class UserStatusWidget extends StatefulWidget {

  UserStatusWidget({
    @required this.user,
  });

  final UserModel user;

  @override
  _UserStatusWidgetState createState() => _UserStatusWidgetState();
}

class _UserStatusWidgetState extends State<UserStatusWidget> {

  
  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0), 
      child: Container(
        color: _getColor(widget.user.status),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 12.0, left: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Text(
              //   _getHeading(widget.user.status),
              //   style: TextStyle(fontWeight: FontWeight.bold),
              //   textAlign: TextAlign.left,
              // ),
              Text(
                _getHeading(widget.user.status),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(height: 3.0,),
              Text(
                _getContent(widget.user.status),
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 13.5, color: Colors.black45),
              )
            ],
          )
        ),
        // height: 90.0,
        alignment: Alignment.center,
      ),
    );
  }

  _getColor(String status) {
    switch (status) {
      case 'safe'
        : return AppColors().safe;
      case 'unsafe'
        : return AppColors().unsafe;
      default
        : return AppColors().neutral;
    }
  }

  _getHeading(String status) {
    switch (status) {
      case 'safe'
        : return "You are safe from risk";
      case 'unsafe'
        : return "You are at risk";
      default
        : return "Self-assesment test not taken";
    }
  }

  _getContent(String status) {
    switch (status) {
      case 'safe'
        : return "Keep maintianing personal hygiene and social distance. Let\'s flatten that curve!";
      case 'unsafe'
        : return "You must contact the emergency services immediately! Avoid contact with anyone as far as possible.";
      default
        : return "Proceed as soon as possible to determine if you are at risk.";
    }
  }


}