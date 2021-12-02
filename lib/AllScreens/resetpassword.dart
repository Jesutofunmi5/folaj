import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/login.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllScreens/registration.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';


class ResetPasswordScreen extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();

  static const String idScreen ="reset";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 60.0,),
              Image(image: AssetImage('images/bg.png'),
                height: 150.0,
                width: 250.0,
                alignment: Alignment.center,

              ),
              SizedBox(height: 1.0,),
              Text("Reset Password", style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                  textAlign: TextAlign.center),


              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    //Email Field
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    ),

                    //Password Field



                    SizedBox(height: 20.0,),

                    RaisedButton(
                      color: Color(0xff000093),
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Reset", style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),

                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),

                      onPressed: (){

                        if( !emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("Email is in Valid", context);
                        }
                        else
                        {
                          loginAndAuthenticateUser(context);
                        }
                      },
                    )





                  ],
                ),

              ),



            ],
          ),
        ),
      ),


    );
  }

  //Auth Function Code
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {

    showDialog(

        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return progressDialog(message: "Please wait..........",);
        }
    );





     await FirebaseAuth.instance.sendPasswordResetEmail(email: emailTextEditingController.text).then((value) {
        displayToastMessage("Reset Password Link Sent Successfully!", context);
        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
      });


        }

  }

