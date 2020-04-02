import 'package:covid_19_app/models/video_model.dart';
import 'package:covid_19_app/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class VideoCard extends StatefulWidget {
  final VideoModel video;
  VideoCard({
    @required this.video,
  });

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 35.0),
      child: GestureDetector(
        onTap: () {
          launch(widget.video.link);
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

    if(widget.video.time != null) {
      date = UtilFunctions().parseDate(widget.video.time.toDate().toString(), 'd MMM').toString();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                (widget.video.thumbnail != null) ? Image.network(widget.video.thumbnail) : Container(),
                Image.asset("./assets/youtube.png", height: 40.0,),
              ],
            ),
          ),
          SizedBox(height: 5.0,),
          Text(
            (widget.video.title == null)
            ? " " :
            (widget.video.title.length > 390)
            ? widget.video.title.substring(0, 390) + "..."
            : widget.video.title,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 3.0,),
          Text(
            "$date $time",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          SizedBox(height: 5.0,),
          Text(
            widget.video.channel == null ? " " : widget.video.channel,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14.0
            ),
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}