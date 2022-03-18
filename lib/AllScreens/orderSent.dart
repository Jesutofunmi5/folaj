import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:rider_app/AllScreens/progress.dart';

class OrderSent extends StatefulWidget {
  static const String idScreen = "OrderSent";
  @override
  _OrderSentState createState() => _OrderSentState();
}

class _OrderSentState extends State<OrderSent> {
  @override
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
        context, MaterialPageRoute(builder: (context) => ProgressScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
        body: Column(children: [
      Center(
        child: Lottie.network(
            'https://assets10.lottiefiles.com/packages/lf20_6YCRFI.json'),
      ),
      Container(
        child: Center(
          child: Text(
            'Order Successful Sent',
            style: GoogleFonts.sen(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Container(
          child: Text(
            'Order Successful Sent',
            style: GoogleFonts.sen(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          )),
    ]));
  }
}
