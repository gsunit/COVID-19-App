import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {

  HomeTab({
    @required this.title,
    @required this.icon,
    @required this.color,
    @required this.onTap,
  });

  final String title;
  final Color color;
  final IconData icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(icon, color: Colors.white,),
                SizedBox(width: 30.0,),
                Text(title, style: TextStyle(color: Colors.white),),
                SizedBox(width: 30.0,),
                Icon(Icons.chevron_right, color: Colors.white,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}