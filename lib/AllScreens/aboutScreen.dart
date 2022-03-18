import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  static const String idScreen = "AboutScreen";

  @override
  _MyAboutScreenState createState() => _MyAboutScreenState();
}

class _MyAboutScreenState extends State<AboutScreen> {
  static const String idScreen = "MyAboutScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff5591f),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(90)),
                  color: Color(0xfff5591f),
                  gradient: LinearGradient(
                    colors: [(Color(0xfff5591f)), (Color(0xfff2861e))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.asset("assets/images/small.png"),
                      height: 150,
                      width: double.infinity,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "About",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Text("FOLAJ LAUNDRY.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[600],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              alignment: Alignment.topCenter,
              child: Text(
                  "Folaj Laundry is a leading commercial laundry service that offers commercial pickup & delivery. We offer premium commercial laundry services that are quicker, cleaner, and more affordable. Our team goes the distance to ensure that you have professional end-to-end commercial laundering services you can trust.",
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 17,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
