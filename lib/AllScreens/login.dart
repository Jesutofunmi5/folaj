import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/home.dart';
import 'package:rider_app/AllScreens/registration.dart';
import 'package:rider_app/AllScreens/resetpassword.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String userId = FirebaseAuth.instance.currentUser.uid;

  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

class LoginScreen extends StatefulWidget {
  static const String idScreen = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  String _token;

  ConfirmationResult webConfirmationResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90)),
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
                        child: Image.asset("assets/images/icons.png"),
                        height: 130,
                        width: double.infinity,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20, top: 20),
                        alignment: Alignment.bottomRight,
                        child: const Text("Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
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
                    //Email Field
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      cursorColor: Color(0xfff5591f),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email_outlined,
                            color: Color(0xfff5591f),
                          ),
                          hintText: "Enter Email",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
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
                    //Password Field
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      cursorColor: Color(0xfff5591f),
                      obscureText: true,
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
                  Container(
                    margin: const EdgeInsets.only(top: 20, right: 20),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: const Text(
                        "Forget Password",
                        style: TextStyle(
                            color: Color(0xffF5591F),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(),
                          ),
                        ),
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => {
                      if (!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("Email is in Valid", context),
                        }
                      else if (passwordTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("Enter Password", context),
                        }
                      else
                        {
                          loginAndAuthenticateUser(context),
                        }
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 40),
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      alignment: Alignment.center,
                      height: 54,
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
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't Have Account? "),
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationScreen()))
                          },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                              color: Color(0xffF5591F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

//Auth Function Code
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Authenticating, Please wait..........",
          );
        });

    final User user = (await _firebaseauth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Incorrect Password or Email. ", context);
    }))
        .user;

    if (user != null) // user created
    {
      // store user data

      usersRef.doc(user.uid).get().then((snap) {
        if (snap.exists) {
          displayToastMessage("Logged-In Successfully!", context);
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.idScreen, (route) => false);
        } else {
          Navigator.pop(context);
          _firebaseauth.signOut();
          displayToastMessage(
              "No record exists for this User, Please create Account ",
              context);
        }
      });
    } else {
      Navigator.pop(context);
      displayToastMessage("Error Occur,  can not be sign in", context);
    }
  }
}
