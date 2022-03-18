import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String message;
  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xffF5591F),
      child: Container(
        margin: EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(
                width: 6.0,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              SizedBox(
                width: 18.0,
              ),
              Text(
                message,
                style: TextStyle(color: Colors.black, fontSize: 10.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
