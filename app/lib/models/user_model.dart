import 'package:flutter/widgets.dart';

class UserModel {
  
  final String name;
  final String email;
  final String photo;
  final String uid;
  final String status;

  UserModel({
    @required this.name,
    @required this.email,
    @required this.photo,
    @required this.uid,
    @required this.status,
  });

}