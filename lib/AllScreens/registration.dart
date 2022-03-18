import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/AllScreens/home.dart';
import 'package:rider_app/AllScreens/login.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';

class RegistrationScreen extends StatefulWidget {
  static const String idScreen = "RegistrationScreen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

TextEditingController nameTextEditingController = TextEditingController();
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController phoneTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
TextEditingController confirmTextEditingController = TextEditingController();

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  gradient: LinearGradient(
                    colors: [(Color(0xffF5591F)), (Color(0xffF2861E))],
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
                      child: Image.asset("assets/images/icons.png"),
                      height: 100,
                      width: double.infinity,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, top: 10),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),

              //Name Field
              alignment: Alignment.center,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: nameTextEditingController,
                cursorColor: Color(0xfff5591f),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xfff5591f),
                    ),
                    hintText: "Full Name",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),

            //Email field

            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailTextEditingController,
                cursorColor: Color(0xfff5591f),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color(0xfff5591f),
                    ),
                    hintText: "Email Address",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),

            //Phone Field
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneTextEditingController,
                cursorColor: Color(0xfff5591f),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Color(0xfff5591f),
                    ),
                    hintText: "Phone Number",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),

            //Password Field
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordTextEditingController,
                cursorColor: Color(0xfff5591f),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Color(0xfff5591f),
                    ),
                    hintText: "Enter Password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            //Password Field
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: confirmTextEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                cursorColor: Color(0xfff5591f),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Color(0xfff5591f),
                    ),
                    hintText: "Confirm Password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),

            GestureDetector(
              onTap: () => {
                if (nameTextEditingController.toString().length < 4)
                  {
                    displayToastMessage(
                        "Name Must be at least 3 character ", context),
                  }
                else if (!emailTextEditingController.text.contains("@"))
                  {
                    displayToastMessage("Email is not Valid", context),
                  }
                else if (phoneTextEditingController.text.length != 11)
                  {
                    displayToastMessage("Confirm Phone Number", context),
                  }
                else if (passwordTextEditingController.text.length < 7)
                  {
                    displayToastMessage(
                        "Password Must be at least More than 6 character",
                        context),
                  }
                else if (passwordTextEditingController.text !=
                    confirmTextEditingController.text)
                  {
                    displayToastMessage(
                        "Password must be same as above", context),
                  }
                else
                  {
                    registerNewUser(context),
                  }
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                alignment: Alignment.center,
                height: 54,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [(Color(0xfff5591f)), (Color(0xfff2861e))],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE))
                  ],
                ),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Member? "),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    },
                    child: Text(
                      "Login Now",
                      style: TextStyle(
                          color: Color(0xffF5591F),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //Sign up Function
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering, Please wait..........",
          );
        });
    try {
      await _firebaseauth
          .createUserWithEmailAndPassword(
              email: emailTextEditingController.text,
              password: passwordTextEditingController.text)
          .catchError((errMsg) {
        Navigator.pop(context);

        displayToastMessage("Error: Something went wrong $errMsg", context);
      }).then((value) {
        if (value != null) {
          final User user = value.user;

          //check user

          if (user != null) // user created
          {
            // store user data
            var userDataMap = {
              "name": nameTextEditingController.text.trim(),
              "email": emailTextEditingController.text.trim(),
              "phone": phoneTextEditingController.text.trim(),
            };
            usersRef.doc(user.uid).set(userDataMap).then((value) {
              displayToastMessage(
                  "Congratulation User Account Created Successfully!", context);
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.idScreen, (route) => false);
            }).catchError((onError) => log(onError));
          } else {
            Navigator.pop(context);
            displayToastMessage(
                "New user account has not been created", context);
          }
        }
      });
    } catch (e) {
      log("|error ---- $e");
    }
  }
}

//Flutter Toast MessageCodec

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
