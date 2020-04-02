import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReverseCountdown extends StatelessWidget {

  final amtController = TextEditingController();
  //when using reverse countdown in your own app, change debugMode to false and provide the requied dDay values.
  final bool debugMode = true;
  DateTime now = DateTime.now();
  DateTime dDay = DateTime(2018, 11, 26, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    dDay = (debugMode)
        ? DateTime(now.year, now.month + 2, now.day, now.hour, now.minute,
            now.second + 10)
        : dDay;

    Duration _duration = dDay.difference(now);

    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "Next reminder in:",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10.0,),
          FlipClock.reverseCountdown(
            duration: _duration,
            digitColor: Colors.white,
            backgroundColor: Colors.black,
            digitSize: 30.0,
            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
            //onDone: () => print('ih'),
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: (){},
                child: Text("Remind me daily at (hrs)", style: TextStyle(color: Colors.white)),
                color: Colors.lightGreen,
              ),
              Container(
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
          ),
            ],
          ),
          
        ],
      ),
    );
  }
}