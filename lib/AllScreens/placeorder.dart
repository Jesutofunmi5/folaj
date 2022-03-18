import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/AllScreens/progress.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';
import 'package:rider_app/Assistants/requestAssistant.dart';
import 'package:rider_app/DataHandler/appData.dart';
import 'package:rider_app/Models/address.dart';
import 'package:rider_app/configMaps.dart';
import 'package:rider_app/placePredictions.dart';

class PlaceOrder extends StatefulWidget {
  static const String idScreen = "PlaceOrder";

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController pickUpTextEditing = TextEditingController();
  TextEditingController dropOffTextEditing = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

  final GlobalKey<FormState> form = GlobalKey();

  // Initial Selected Value
  String dropdownvalue = 'Washing Only';

  // List of items in our dropdown menu
  var items = [
    'Washing Only',
    'Ironing Only',
    'Dry Cleaning',
    'Wash and Iron',
  ];

  String value;
  String name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      log('data --- ${value.data()}');
      name = value.data()['name'];
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff5591f),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Form(
              key: form,
              child: Column(children: [
                Container(
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(90)),
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
                          margin: const EdgeInsets.only(left: 20, top: 20),
                          alignment: Alignment.bottomLeft,
                          child: Text("Confirm your details",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                    controller: nameTextEditingController,
                    key: ValueKey('name'),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xfff5591f),
                        ),
                        hintText: "Name",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 5,
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

                  //Address Field
                  alignment: Alignment.center,
                  child: TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    controller: addressTextEditingController,
                    cursorColor: Color(0xFFF5591F),
                    key: ValueKey('Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some your Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.home_filled,
                          color: Color(0xfff5591f),
                        ),
                        hintText: "e.g.. Johnson awe st,Ibadan",
                        labelText: 'Pickup Address',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                  //phone Field
                  alignment: Alignment.center,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                    cursorColor: Color(0xfff5591f),
                    key: ValueKey('phone'),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone_android,
                          color: Color(0xfff5591f),
                        ),
                        hintText: "Phone Number",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),

                //dropdown menu

                Container(
                    width: double.infinity,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButton(
                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownvalue = newValue;
                            });
                          },
                        ),
                      ],
                    )),

                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                  //date Field
                  alignment: Alignment.center,
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: dateTextEditingController,
                    cursorColor: Color(0xfff5591f),
                    key: ValueKey('date'),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.date_range,
                          color: Color(0xfff5591f),
                        ),
                        hintText: "25/01/2022",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          minLines: 2,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Color(0xfff5591f),
                          controller: messageTextEditingController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            hintText: 'Enter it here.........',
                            labelText: "Any Special Request ?",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // next button

                GestureDetector(
                  onTap: () {
                    if (form.currentState.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressScreen(data: {
                                  "name": nameTextEditingController.text,
                                  "address": addressTextEditingController.text,
                                  "phone": phoneNumberController.text,
                                  "messages": messageTextEditingController.text,
                                  "value": dropdownvalue,
                                  "date": dateTextEditingController.text,
                                })),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
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
                      "Order Now",
                      style: TextStyle(
                        color: Color(0xffEEEEEE),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]))
        ])));
  }
}

void getPlaceAddressDetails(String placeId, context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
            message: "Setting DropOff, Please wait.......",
          ));
  String placeDetailsUrl =
      "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

  var res = await RequestAssistant.getRequest(placeDetailsUrl);
  Navigator.pop(context);
  if (res == "failed") {
    return;
  }
  if (res["status"] == "OK") {
    Address address = Address();
    address.placeName = res["result"]["name"];
    address.placeId = placeId;
    address.latitude = res["result"]["geometry"]["location"]["lat"];
    address.longitude = res["result"]["geometry"]["location"]["lng"];

    Provider.of<AppData>(context, listen: false)
        .updateDropOffLocationAddress(address);

    print("Drop off location::");
    print(address.placeName);
    Navigator.pop(context, "obtainDirection");
  }
}

void findPlace(String text) {}
