import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_app/feed/govt_guidelines_card.dart';
import 'package:covid_19_app/models/govt_guidelines_model.dart';
import 'package:covid_19_app/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GovtGuidelinesPage extends StatefulWidget {
  @override
  _GovtGuidelinesPage createState() => _GovtGuidelinesPage();
}

class _GovtGuidelinesPage extends State<GovtGuidelinesPage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Govt. Updates"),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset("./assets/indian_emblem.png", width: MediaQuery.of(context).size.width*0.6),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: StreamBuilder(
                  stream: Firestore.instance.collection('guidelines').snapshots(),
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
                                                  child: GovtGuidelinesCard(
                                                  guideline: new GovtGuidelinesModel(
                                                    handle: snapshot.data.documents[index]['handle'],
                                                    link: snapshot.data.documents[index]['link'],
                                                    time: snapshot.data.documents[index]['time'],
                                                    title: snapshot.data.documents[index]['title'],
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
        ],
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
        new GovtGuidelinesPage();
      });
    });
    return completer.future;
  } 
}
