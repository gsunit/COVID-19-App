import 'dart:async';

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
            child: Column(
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
                                        handle: "@who",
                                        link: "https://twitter.com/WHO/status/1244950413490741248",
                                        time: "9999",
                                        tweet: "#COVID19 home-caregivers: Ensure ill person rests, drinks plenty fluids & eats nutritiously Wear Face with medical mask when in same room Clean Raising hands frequently Use dedicated Fork and knife with plate Glass of milk towel & bedlinen for ill person Disinfect surfaces touched by ill person Telephone receiver healthcare facility if person has difficulty breathing"
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: 2,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
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