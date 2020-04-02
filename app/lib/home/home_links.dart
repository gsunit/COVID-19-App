import 'package:flutter/material.dart';

class HomeLinks extends StatelessWidget {

  HomeLinks({
    @required this.title,
    @required this.onTap,
  });

  final String title;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(title, style: TextStyle(color: Colors.black87, fontSize: 12.0),),
                    SizedBox(width: 30.0,),
                    Icon(Icons.chevron_right, color: Colors.black87,),
                  ],
                ),
                Divider(thickness: 1.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}