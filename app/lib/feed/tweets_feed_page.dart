import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_app/feed/tweet_card.dart';
import 'package:covid_19_app/models/tweet_model.dart';
import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TweetsFeedPage extends StatefulWidget {
  @override
  _TweetsFeedPageState createState() => _TweetsFeedPageState();
}

class _TweetsFeedPageState extends State<TweetsFeedPage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Tweets"),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: StreamBuilder(
              stream: Firestore.instance.collection('tweets').snapshots(),
              builder: (BuildContext context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                if(snapshot.hasData) {
                  if(snapshot.data != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: EasyRefresh.custom(
                            header: BallPulseHeader(color: Colors.blue),
                            footer: BallPulseFooter(),
                            onRefresh: _handleRefresh,
                            key: _refreshIndicatorKey,
                            slivers: <Widget>[
                              AnimationLimiter(
                                child: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration: const Duration(milliseconds: 300),
                                          child: SlideAnimation(
                                            child: FadeInAnimation(
                                              child: TweetCard(
                                              tweet: new TweetModel(
                                                handle: snapshot.data.documents[index]['handle'],
                                                link: snapshot.data.documents[index]['link'],
                                                time: snapshot.data.documents[index]['time'],
                                                tweet: snapshot.data.documents[index]['tweet'],
                                                hashTag: snapshot.data.documents[index]['hashTag']
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: snapshot.data.documents.length,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async{
   
    _refreshIndicatorKey.currentState?.show(atTop: false);
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(seconds: 1)).then((_){
      completer.complete();
        setState(() {
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new NewsFeedPage()));
        print('new newsfeed');
        new TweetsFeedPage();
      });
    });
    return completer.future;
  } 
}
