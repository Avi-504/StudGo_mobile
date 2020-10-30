import 'dart:async';

import 'package:StudGo/models/users.dart';
import 'package:animator/animator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LandUpPage.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
final userRef = Firestore.instance.collection('users');
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  bool stopAnim = true;
  PageController pageController;
  int pgIndex = 0;
  String userguide;
  var newUser = false;

  @override
  void initState() {
    pageController = PageController();
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    });
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error Signing in: $err');
      super.initState();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void createUserInFirestore() async {
    final user = googleSignIn.currentUser;
    DocumentSnapshot doc = await userRef.document(user.email).get();
    if (!doc.exists) {
      newUser = true;
      userRef.document(user.email).setData({
        'photoUrl': user.photoUrl,
        'email': user.email,
        'displayName': user.displayName,
      });
      doc = await userRef.document(user.email).get();
      currentUser = User.fromDocument(doc);
    } else {
      newUser = false;
      currentUser = User.fromDocument(doc);
    }
  }

  void login() async {
    final googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
  }

  void logout() {
    googleSignIn.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Home(),
    ));
    Navigator.of(context).pop();
  }

  void handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  void anim() {
    Timer(Duration(milliseconds: 1200), () {
      setState(() {
        stopAnim = false;
      });
    });
  }

  Scaffold signin() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.grey[900],
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            stopAnim
                ? Animator(
                    duration: Duration(milliseconds: 1200),
                    tween: Tween(begin: 0.0, end: 1.2),
                    curve: Curves.easeInOut,
                    cycles: 0,
                    builder: (context, animatorState, child) => Transform.scale(
                      scale: animatorState.value,
                      child: Container(
                        width: 450,
                        height: 450,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/studGO.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 450,
                    height: 450,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/studGO.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            SizedBox(
              height: 12,
            ),
            InkWell(
              child: Container(
                width: 260,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: login,
            ),
          ],
        ),
      ),
    );
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      pgIndex = pageIndex;
    });
  }

  void onBottomBarTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    anim();
    return isAuth
        ? LandUpPage(
            newUser
                ? userguide =
                    'Start your Technical journey with StudGo in a very fun and intitutive way'
                : 'Welcome Back To StudGO continue Your Technical Journey with us..',
            logout)
        : signin();
  }
}
