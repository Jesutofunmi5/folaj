import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/registration.dart';
import 'package:rider_app/AllScreens/resetMessage.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';

class ResetPasswordScreen extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();

  static const String idScreen = "reset";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
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
                      child: Text("Reset Password",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 80),
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
              //Email Field
              alignment: Alignment.center,
              child: TextFormField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Color(0xfff5591f),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Color(0xfff5591f),
                    ),
                    hintText: "Enter Email",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!emailTextEditingController.text.contains("@")) {
                  displayToastMessage("Email is in Valid", context);
                } else {
                  loginAndAuthenticateUser(context);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                padding: EdgeInsets.only(
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
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE))
                  ],
                ),

                //Password Field

                child: Text(
                  "RESET PASSWORD",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Auth Function Code
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Please wait..........",
          );
        });

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailTextEditingController.text)
        .then((value) {
      // displayToastMessage("Reset Password Link Sent Successfully!", context);
      Navigator.pushNamedAndRemoveUntil(
          context, Thanks.idScreen, (route) => false);
    });
  }
}
