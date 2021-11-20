import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoCleanerAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),

      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0)
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),

              Text("Folaj Laundry Not Available at the moment",  overflow: TextOverflow.ellipsis,  style: TextStyle( fontSize: 22, fontFamily: "Brand-Bold", fontWeight: FontWeight.bold),),

                SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("We suggest you try calling the office phone number(07060671000) or try back shortly",  textAlign: TextAlign.center,  style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold),),
              ),

          SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: ()
                   {
                         Navigator.pop(context);
                    },
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                            "Close", style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold", fontWeight: FontWeight.bold),
                          ),
                            Icon(Icons.close_rounded, color: Colors.white, size: 26,)

                      ]
                        ),

                  ),
                )


            ),
            ]
          )
        ),
      ),
      )
    );
  }
}
