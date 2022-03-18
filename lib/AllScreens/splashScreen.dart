import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/login.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllScreens/registration.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import 'welcomeScreen.dart';

class NewSpalshPage extends StatefulWidget {
  static const String idScreen = "SpalshScreen";
  @override
  _NewSpalshPageState createState() => _NewSpalshPageState();
}

class _NewSpalshPageState extends State<NewSpalshPage> {
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 8);
    return Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white38,
            ),
          ),
          Center(
            child: Lottie.network(
              "https://assets7.lottiefiles.com/packages/lf20_fqcfonax.json",
              height: 250,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
