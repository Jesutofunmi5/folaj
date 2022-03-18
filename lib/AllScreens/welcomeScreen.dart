import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/login.dart';
import 'package:rider_app/AllScreens/registration.dart';
import 'package:rider_app/AllWidget/widgets.dart';

class WelcomePage extends StatelessWidget {
  static const String idScreen = "welcome";
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: 50),
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(90.0),
                    child: Container(
                      child: Image.asset(
                        "assets/images/small.png",
                        height: 60,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // main content start here...........................
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        "You are what you wear !",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 10),
                      child: Text(
                        "Be clean, be fresh, With just one click, We deliver to your doorstep. ",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    //button
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()))
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.black,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 2.0, color: Colors.white),
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),

                    //2nd button
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen()))
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [(Color(0xfff5591f)), (Color(0xfff2861e))],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "CREATE ACCOUNT",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
