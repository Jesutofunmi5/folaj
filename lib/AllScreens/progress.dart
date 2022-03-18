import 'dart:math';
import 'dart:developer' as i;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:rider_app/AllScreens/success.dart';

class ProgressScreen extends StatefulWidget {
  static const String idScreen = "ProgressScreen";
  final data;

  const ProgressScreen({Key key, this.data}) : super(key: key);
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    widget.data['orderId'] = getRandInt();
    widget.data['senderUid'] = FirebaseAuth.instance.currentUser.uid;
    i.log("yo --- ${widget.data}]");
    FirebaseFirestore.instance
        .collection('Orders')
        .add(widget.data)
        .then((value) => loginRoute());
  }

  String getRandInt() {
    var rnd = Random();
    return 'FL-${rnd.nextInt(9999)}';
  }

  loginRoute() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SucessScreen(widget.data['orderId'])));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_nmsjhjh6.json',
                height: 250,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'Processsing Order.....',
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
