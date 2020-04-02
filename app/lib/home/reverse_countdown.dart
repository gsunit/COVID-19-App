import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReverseCountdown extends StatefulWidget {

  @override
  _ReverseCountdownState createState() => _ReverseCountdownState();
}

class _ReverseCountdownState extends State<ReverseCountdown> {
  final amtController = TextEditingController();

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
              _buildButtons(),
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

  _buildButtons() {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: (){},
          child: Text("Remind me daily at (hrs)", style: TextStyle(color: Colors.white)),
          color: Colors.lightGreen,
        ),
        RaisedButton(
          onPressed: (){},
          child: Text("Info", style: TextStyle(color: Colors.white)),
          color: Colors.lightBlue,
        ),
      ],
    );
  }

  void _checkValidation(BuildContext context, String appName) {
    if (amtController.text == "") {
      final snackBar = SnackBar(
        content: Text('Please enter the time'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    // _transaction = initiateTransaction(appName, amtController.text);
    setState(() {});
  }
}