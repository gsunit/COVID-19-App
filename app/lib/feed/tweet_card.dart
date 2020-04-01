import 'package:covid_19_app/models/tweet_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TweetCard extends StatefulWidget {
  final TweetModel tweet;
  TweetCard({
    @required this.tweet,
  });

  @override
  _TweetCardState createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 35.0),
      child: GestureDetector(
        onTap: () {
          launch(widget.tweet.link);
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
    var date = "8888";
    var time = "7777";
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.tweet.handle,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              ),
              Icon(Icons.info, color: Colors.blue,)
            ],
          ),
          SizedBox(height: 10.0,),
          Text(
            (widget.tweet.tweet.length > 390)
            ? widget.tweet.tweet.substring(0, 390) + "..."
            : widget.tweet.tweet,
            style: TextStyle(
              color: Colors.grey,
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