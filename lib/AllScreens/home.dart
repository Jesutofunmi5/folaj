import 'dart:developer';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider_app/AllScreens/aboutScreen.dart';
import 'package:rider_app/AllScreens/find.dart';
import 'package:rider_app/AllScreens/fullservices.dart';
import 'package:rider_app/AllScreens/historyScreen.dart';
import 'package:rider_app/AllScreens/login.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllScreens/mapScreen.dart';

import 'package:rider_app/AllScreens/servicesScreen.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<int> currentIndex = ValueNotifier(0);

  String name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      log('data --- ${value.data()}');
      name = value.data()['name'];
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: currentIndex,
        builder: (context, index, child) {
          log("index  -- \\\\\\\ $index");
          return Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.indigo.shade50,
                buttonBackgroundColor: Colors.white,
                height: 45,
                items: [
                  Icon(
                    Icons.home,
                    color: index == 0 ? Color(0xfff2861e) : Color(0xfff2861e),
                    size: 25.0,
                  ),
                  Icon(
                    Icons.local_laundry_service_outlined,
                    color: index == 1
                        ? Color(0xfff2861e)
                        : const Color(0xfff2861e),
                    size: 25.0,
                  ),
                  Icon(
                    Icons.person,
                    color: index == 2 ? Color(0xfff2861e) : Color(0xfff2861e),
                    size: 25.0,
                  ),
                ],
                onTap: (index) {
                  currentIndex.value = index;

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ServicesScreen(),
                  //   ),
                  // ),
                },
              ),
              backgroundColor: Colors.indigo.shade50,
              appBar: AppBar(
                backgroundColor: Color(0xfff5591f),
                centerTitle: true,
                title: Image.asset(
                  'assets/images/small.png',
                  scale: 1.8,
                  alignment: Alignment.topCenter,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add_alert),
                    tooltip: 'Show Snackbar',
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen()),
                      );
                    },
                  ),
                ],
              ),
              drawer: Container(
                color: Colors.white,
                width: 240.0,
                child: Drawer(
                  child: ListView(
                    children: [
                      //Drawer header

                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xfff5591F),
                            gradient: LinearGradient(
                                colors: [
                                  (Color(0xfff5591f)),
                                  (Color(0xfff2861e))
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        width: double.infinity,
                        height: 200,
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 70,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/icons.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            //     Column(
                            //       children: [
                            //         Text('Name: ${name}'),
                            //       ],
                            //     ),
                            //     Text('Email: ${email}'),
                            //   ],
                            // ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 12.0,
                      ),

                      //Drawer Body
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Color(0xfff5591f),
                          ),
                          title: Text(
                            "Dashboard",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryScreen()));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.history,
                            color: Color(0xfff5591f),
                          ),
                          title: Text(
                            "History",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullServicesScreen()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.local_laundry_service_outlined,
                              color: Color(0xfff5591f)),
                          title: Text(
                            "Services",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          MapUtils.openMap(7.382194, 3.828750);
                        },
                        child: ListTile(
                          leading:
                              Icon(Icons.pin_drop, color: Color(0xfff5591f)),
                          title: Text(
                            "Find Folaj",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutScreen()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.info, color: Color(0xfff5591f)),
                          title: Text(
                            "About",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.idScreen, (route) => false);
                        },
                        child: ListTile(
                          leading: Icon(Icons.logout, color: Color(0xfff5591f)),
                          title: Text(
                            "Sign Out",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                  child: index == 0
                      ? Container(
                          margin: const EdgeInsets.only(
                              top: 18, left: 24, right: 24),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome ' + '$name....',
                                    style: GoogleFonts.sairaCondensed(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey[400],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      const SizedBox(height: 5),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          _cardMenu(
                                              title: 'Wash',
                                              icon: 'assets/images/mach.png',
                                              color: Colors.transparent,
                                              fontColor: Colors.black,
                                              onTap: () => {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             MainScreen()))
                                                  }),
                                          _cardMenu(
                                            title: 'Iron',
                                            icon: 'assets/images/iron.png',
                                            color: Colors.transparent,
                                            fontColor: Colors.black,
                                            onTap: () => {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             MainScreen()))
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          _cardMenu(
                                            title: 'Dry Clean',
                                            icon: 'assets/images/dry.png',
                                            color: Colors.transparent,
                                            fontColor: Colors.black,
                                            onTap: () => {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             MainScreen()))
                                            },
                                          ),
                                          _cardMenu(
                                            title: 'Wash & Iron',
                                            icon: 'assets/images/wash.png',
                                            color: Colors.transparent,
                                            fontColor: Colors.black,
                                            onTap: () => {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             MainScreen()))
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                          height: 200.0,
                                          width: double.infinity,
                                          child: Carousel(
                                            images: [
                                              ExactAssetImage(
                                                "assets/images/cl.jpg",
                                              ),
                                              ExactAssetImage(
                                                "assets/images/cll.jpg",
                                              ),
                                              ExactAssetImage(
                                                "assets/images/clll.jpg",
                                              ),
                                            ],
                                            dotSize: 4.0,
                                            dotSpacing: 15.0,
                                            dotColor: Colors.grey,
                                            indicatorBgPadding: 5.0,
                                            dotBgColor:
                                                Colors.grey.withOpacity(0.5),
                                            borderRadius: false,
                                            moveIndicatorFromBottom: 180.0,
                                            noRadiusForIndicator: true,
                                          )),
                                    ]),
                              ),
                            ],
                          ),
                        )
                      : index == 1
                          ? ServicesScreen()
                          : ProfilePage()),
              floatingActionButton: new FloatingActionButton(
                  elevation: 0.0,
                  child: new Icon(Icons.add_outlined),
                  backgroundColor: new Color(0xfff2861e),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  }));
        });
  }

  Widget _cardMenu({
    String title,
    String icon,
    VoidCallback onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: 130,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfff5591f)),
          borderRadius: BorderRadius.circular(100),
          color: color,
        ),
        child: Column(
          children: [
            Image.asset(
              icon,
              height: 60,
              width: double.infinity,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
