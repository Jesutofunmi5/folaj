import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/AllScreens/login.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';

class RegistrationScreen extends StatelessWidget {

  static const String idScreen ="register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 30.0,),
              Image(image: AssetImage('images/bg.png'),
                height: 150.0,
                width: 250.0,
                alignment: Alignment.center,

              ),
              SizedBox(height: 1.0,),
              Text("Sign Up as a User", style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                  textAlign: TextAlign.center),


              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    //Name Field
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
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

                    SizedBox(height: 1.0,),
                    //Phone Field
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
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
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
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

                    SizedBox(height: 20.0,),

                    RaisedButton(
                      color: Color(0xff000093),
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Sign Up", style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),

                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),

                      onPressed: (){

                        if( nameTextEditingController.toString().length < 4)
                        {
                                displayToastMessage("Name Must be at least 3 character ", context);
                        }
                        else if( !emailTextEditingController.text.contains("@"))
                        {
                              displayToastMessage("Email is not Valid", context);
                        }

                        else if ( phoneTextEditingController.text.isEmpty)
                          {
                               displayToastMessage("Phone Number is Mandatory", context);
                          }
                        else if( passwordTextEditingController.text.length < 7)
                          {
                              displayToastMessage("Password Must be at least More than 6 character", context);

                          }

                        else
                          {
                          registerNewUser(context);
                          }

                      },
                    )





                  ],
                ),

              ),

              FlatButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(" Already have an Account? Login Here."),
              ),

            ],
          ),
        ),
      ),


    );
  }


  //Sign up Function
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async{

    showDialog(

        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return progressDialog(message: "Registering, Please wait..........",);
        }
    );

    final User user = (await _firebaseauth.
    createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
       ).catchError((errMsg){
          Navigator.pop(context);
          displayToastMessage("Error: Something went wrong", context);
              }
    )).user;


    //check user

    if( user != null ) // user created
    {
        // store user data
        Map userDataMap = {
          "name" : nameTextEditingController.text.trim(),
          "email" : emailTextEditingController.text.trim(),
          "phone" : phoneTextEditingController.text.trim(),

        };
        usersRef.child(user.uid).set(userDataMap);
        displayToastMessage("Congratulation User Account Created Successfully!", context);
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    }
    else
      {
        Navigator.pop(context);
         displayToastMessage("New user account has not been created", context);
     }

  }
}



       //Flutter Toast MessageCodec

       displayToastMessage(String message, BuildContext context){
                Fluttertoast.showToast(msg: message);

}