import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_app/home/home_page.dart';
import 'package:covid_19_app/models/user_model.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReverseCountdown extends StatefulWidget {

  ReverseCountdown({
    @required this.homeTitle,
    @required this.user,
    @required this.hrs,
  });

  final String homeTitle;
  final UserModel user;
  final int hrs;

  @override
  _ReverseCountdownState createState() => _ReverseCountdownState();
}

class _ReverseCountdownState extends State<ReverseCountdown> {
  final amtController = TextEditingController();

  @override
  void initState() { 
    super.initState();
    amtController.text = widget.hrs.toString();
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
    dDay = _setDDay(widget.hrs, now);

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
            duration:  _duration,
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
          onPressed: (){
            _checkValidation(context);
          },
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

  void _checkValidation(BuildContext context) {
    if (amtController.text == "") {
      final snackBar = SnackBar(
        content: Text('Please enter the time'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    if(int.parse(amtController.text) > 23) {
      final snackBar = SnackBar(
        content: Text('Please enter a number between 0 and 23'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    
    // _duration = dDay.difference(now);
    // _transaction = initiateTransaction(appName, amtController.text);
    setState(() async {
      final snackBar = SnackBar(
        content: Text('Setting reminder for ${amtController.text}:00 hrs'),
      );
      var userSnapshot = await Firestore.instance.collection('users').document(widget.user.email).get()
        .catchError((e){print("e #61: $e");});
      UserModel userModel = widget.user;
      userModel.visits = userSnapshot.data['visits'];

      Scaffold.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(
        title: widget.homeTitle,
        user: userModel,
        hrs: int.parse(amtController.text),
      )));
    });
  }

  _setDDay(int hrs, DateTime now) {
    if(hrs > now.hour) {
      return DateTime(now.year, now.month, now.day, hrs, 0, 0);
    }
    else {
      return DateTime(now.year, now.month, now.day+1, hrs, 0, 0);
    }
  }
}