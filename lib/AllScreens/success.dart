import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:rider_app/AllScreens/home.dart';

class SucessScreen extends StatefulWidget {
  final String data;
  SucessScreen(this.data);

  @override
  _SucessScreenState createState() => _SucessScreenState();
}

class _SucessScreenState extends State<SucessScreen> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Text(
                'Thank You For Ordering, \nWe have a great deal.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            Center(
              child: Lottie.network(
                "https://assets7.lottiefiles.com/packages/lf20_hwiel3vi.json",
                height: 300,
                width: double.infinity,
              ),
            ),

            Container(
              child: Center(
                child: Text(
                  'Your Order has been approved and \nFolaj rider will be on the way to \npick it shortly.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'ORDER NO: ${widget.data}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

//DONE button start

            GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()))
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [(Color(0xfff5591f)), (Color(0xfff2861e))],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE))
                  ],
                ),
                child: const Text(
                  "DONE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //DONE button end!
          ],
        ),
      ),
    );
  }
}
