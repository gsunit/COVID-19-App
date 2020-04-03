import 'package:covid_19_app/fonts/twitter_icon.dart';
import 'package:covid_19_app/models/govt_guidelines_model.dart';
import 'package:covid_19_app/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class GovtGuidelinesCard extends StatefulWidget {

  final GovtGuidelinesModel guideline;

  GovtGuidelinesCard({
    @required this.guideline,
  });

  @override
  _GovtGuidelinesCardState createState() => _GovtGuidelinesCardState();
}

class _GovtGuidelinesCardState extends State<GovtGuidelinesCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 35.0),
      child: GestureDetector(
        onTap: () {
          launch(widget.guideline.link);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => new MyWebviewScaffold(
          //       url: widget.tweet.link,
          //     )
          //     // builder: (context) => new FeedDetailsPage(feedModel: widget.feed,),
          //   )
          // );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 14.0,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }

  _buildText() {
    var date = " ";
    var time = " ";

    if(widget.guideline.time != null) {
      date = UtilFunctions().parseDate(widget.guideline.time.toDate().toString(), 'd MMM,').toString();
      time = UtilFunctions().parseTime(widget.guideline.time.toDate().toString(), 'kk:mm').toString();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.guideline.handle == null ? " " : widget.guideline.handle,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.blue,
              fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0,),
          Text(
            (widget.guideline.title == null)
            ? " " :
            (widget.guideline.title.length > 390)
            ? widget.guideline.title.substring(0, 390) + "..."
            : widget.guideline.title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            "$date $time",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}