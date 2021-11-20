import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';

class ServicesScreen extends StatefulWidget
{
  static const String idScreen = "services";

  @override
  _MyServicesScreenState createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              height: 220,
              child: Center(
                child: Image.asset('images/bg.png', height: 100, width: 150,),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 24, right: 24),
              child: Column(
                children: <Widget>[
                  Text(
                    'Folaj Laundry Services',
                    style: TextStyle(
                        fontSize: 40, fontFamily: 'Signatra'),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'This are the services Folaj Laundry Offer, \n'
                        'Washing and Ironing \n'
                        'Dry Cleaning \n'
                        'Ironing \n'
                        'Duvets and Bulky Items',
                    style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
                },
                child: const Text(
                    'Go Back',
                    style: TextStyle(
                        fontSize: 18, color: Colors.black
                    )
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0))
            ),
          ],
        ));
  }
}