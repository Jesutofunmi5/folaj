import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/main.dart';

class CollectFareDialog extends StatelessWidget
{
  final String paymentMethod;
  final int fareAmount;

  CollectFareDialog({this.paymentMethod, this.fareAmount});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 22.0,),

            Text("Items Collection", style: TextStyle(fontSize: 16.0, fontFamily: "Brand Bold"),),

            SizedBox(height: 22.0,),

            Divider(height: 2.0, thickness: 2.0,),

            SizedBox(height: 16.0,),

            //Text("\#$fareAmount", style: TextStyle(fontSize: 50.0, fontFamily: "Brand Bold"),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Price not Fixed, Highly Negotiable", style: TextStyle(fontSize: 15.0, fontFamily: "Brand Bold"),),
            ),

            SizedBox(height: 16.0,),SizedBox(height: 16.0,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("This is the prove that the laundry man has pickup your item successfully", textAlign: TextAlign.center,),
            ),

            SizedBox(height: 30.0,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: RaisedButton(
                onPressed: () async
                {
                  Navigator.pop(context, "close");


                },
                color: Colors.deepPurpleAccent,
                child: Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Items GiveOut", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),),
                      Icon(Icons.delivery_dining, color: Colors.white, size: 26.0,),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }
}
