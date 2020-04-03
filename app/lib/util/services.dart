import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_app/home/home_page.dart';
import 'package:covid_19_app/login_page.dart';
import 'package:covid_19_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Services {
  storeNewUser(user, context) {
    Firestore.instance
        .collection('/users')
        .document(user.email.toString())
        .setData({
      'email': user.email,
      'uid': user.uid,
      'name': user.displayName,
      'status': 'neutral',
      'visits': 1
    }).then((value) {
      // Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      // TODO: handle this error properly
      print("my_debug: $e");
    });
  }

  signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    }).catchError((e) {
      // TODO: handle this error properly
      print("my_debug: $e");
    });
  }

  isFirstLogin(signedInUser) async {
    final QuerySnapshot snapshot = await Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: signedInUser.uid)
        .limit(1)
        .getDocuments()
        .catchError((e) {
      print("e #10: $e");
    });

    final List<DocumentSnapshot> documents = snapshot.documents;

    final bool isFirstLogin = (documents.length == 0);

    if (!isFirstLogin) {
      print("db #12: ${signedInUser.email} already exists");
    }

    return isFirstLogin;
  }

  void signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    int visits;
    print("signed in as ${currentUser.displayName}");
    // if(UserManagement().isFirstGoogleLogin(currentUser) == true) {
    //   UserManagement().storeNewGoogleUser(currentUser, context);
    // }
    await Services().isFirstLogin(currentUser).then((isFirstLogin) {
      if (isFirstLogin == true) {
        print("db #40: Storing new user ${user.email}");
        Services().storeNewUser(currentUser, context);
      }
      else {
        Firestore.instance.collection('users').document(user.email).get().then((snapshot){
          visits = snapshot.data['visits'];
          print("db #7: visits: $visits");
          Firestore.instance.collection('users').document(user.email).updateData({
            'visits': visits+1
          });
        }).catchError((e){print("e #45: $e");});
        
      }
    }).catchError((e) {
      print("e #40: $e");
    });
    assert(user.uid == currentUser.uid && user.uid != null);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(
      title: "COVID-19 App",
      user: UserModel(
        email: user.email,
        name: user.displayName,
        photo: user.photoUrl,
        status: 'neutral',
        uid: user.uid,
        visits: visits,
      ),
      hrs: 15,
    )));
  }

  updateUserVisits() async {

  }
}