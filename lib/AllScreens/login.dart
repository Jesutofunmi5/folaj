import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllScreens/registration.dart';
import 'package:rider_app/AllScreens/resetpassword.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';


class LoginScreen extends StatelessWidget {
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
  static const String idScreen ="login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 80.0,),
              Image(image: AssetImage('images/bg.png'),
                height: 150.0,
                width: 250.0,
                alignment: Alignment.center,

              ),
               SizedBox(height: 1.0,),
              Text("Login as a User", style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
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

                    SizedBox(height: 15.0,),


                    FlatButton(
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, ResetPasswordScreen.idScreen, (route) => false);
                      },
                      child: Text("                                 Reset Password ?"),
                    ),

                    SizedBox(height: 20,),

                    RaisedButton(
                      color: Color(0xff000093),
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login", style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
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
                        else if(passwordTextEditingController.text.isEmpty)
                          {
                                  displayToastMessage("Password is Mandatory", context);
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

              FlatButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                    },
                child: Text(" Do not have an Account? Register Here."),
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
       return progressDialog(message: "Authenticating, Please wait..........",);
     }
    );


    final User user = (await _firebaseauth.
    signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMsg){
         Navigator.pop(context);
        displayToastMessage("Error: Something went wrong ", context);
    }
    )).user;

    if( user != null ) // user created
        {
      // store user data

      usersRef.child(user.uid).once().then((DataSnapshot snap){

        if( snap.value != null)
        {
          displayToastMessage("Logged-In Successfully!", context);
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
        }
        else
          {
            Navigator.pop(context);
           _firebaseauth.signOut();
           displayToastMessage("No record exists for this User, Please create new record ", context);
         }
      });

    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("Error Occur,  can not be sign in", context);
    }


  }
}
