import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/home.dart';
import 'package:rider_app/AllScreens/login.dart';
import 'package:rider_app/AllScreens/placeorder.dart';
import 'package:rider_app/AllScreens/registration.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/AllScreens/resetMessage.dart';
import 'package:rider_app/AllScreens/resetpassword.dart';
import 'package:rider_app/AllScreens/splashScreen.dart';
import 'package:rider_app/DataHandler/appData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

CollectionReference usersRef = FirebaseFirestore.instance.collection("users");
DatabaseReference driversRef =
    FirebaseDatabase.instance.reference().child("drivers");
DatabaseReference rideRequestRef =
    FirebaseDatabase.instance.reference().child("Ride Requests");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // @override
  // void initState() {
  //   super.initState();
  //   configOneSignel();
  // }

  // void configOneSignel()
  // {
  //   OneSignal.shared.init('08bdebbb-169f-4005-982f-22dec513b80d');
  // }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'FOLAJ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute:
            NewSpalshPage.idScreen, // FirebaseAuth.instance.currentUser == null
        // ? LoginScreen.idScreen
        // : MainScreen.idScreen,
        routes: {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          ResetPasswordScreen.idScreen: (context) => ResetPasswordScreen(),
          NewSpalshPage.idScreen: (context) => NewSpalshPage(),
          HomeScreen.idScreen: (context) => HomeScreen(),
          Thanks.idScreen: (context) => Thanks(),
          PlaceOrder.idScreen: (context) => PlaceOrder(),
        },

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// class Messaging {
//   static String token;
//   static initFCM() async {
//     try {
//       await FCM.initializeFCM(
//           onNotificationPressed: (Map<String, dynamic> data) {},
//           onTokenChanged: (String token) {
//             Messaging.token = token;
//             print(token);
//           },
//           icon: 'icon');
//     } catch (e) {}
//   }
// }
