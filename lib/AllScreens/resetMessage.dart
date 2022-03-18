import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/login.dart';

import 'dart:async';

class Thanks extends StatefulWidget {
  static const String idScreen = "Thanks";
  @override
  _ThanksState createState() => _ThanksState();
}

class _ThanksState extends State<Thanks> {
  void initState() {
    //TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5591f),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 100.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            " ",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Image.asset(
                        "assets/images/mail.png",
                        height: 300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        "Thanks For Connecting with Us",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        "An email message has been sent to your email provided, you can now reset your password with folaj laundary and get the best laundary services from us. ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Image.asset(
                          "assets/images/col.png",
                          height: 100,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
