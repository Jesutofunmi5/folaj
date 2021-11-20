import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/AllScreens/aboutScreen.dart';
import 'package:rider_app/AllScreens/profileTabPage.dart';
import 'package:rider_app/AllScreens/ratingScreen.dart';
import 'package:rider_app/AllScreens/searchScreen.dart';
import 'package:rider_app/AllScreens/servicesScreen.dart';
import 'package:rider_app/AllWidget/CollectFareDialog.dart';
import 'package:rider_app/AllWidget/divider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rider_app/AllWidget/noCleanerAvaliable.dart';
import 'package:rider_app/AllWidget/progressDialog.dart';
import 'package:rider_app/Assistants/assistantMethods.dart';
import 'package:rider_app/Assistants/geoFireAssistant.dart';
import 'package:rider_app/DataHandler/appData.dart';
import 'package:rider_app/Models/directDetails.dart';
import 'package:rider_app/Models/nearByCleaners.dart';
import 'package:rider_app/configMaps.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:rider_app/main.dart';
import 'historyScreen.dart';
import 'login.dart';
import 'package:url_launcher/url_launcher.dart';




class MainScreen extends StatefulWidget {
  static const String idScreen ="main";
  @override
  _MainScreenState createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin
{
  static const colorizeColors = [
    Colors.purple,
    Colors.pink,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.green,

  ];
  static const colorizeTextStyle = TextStyle(
    fontSize: 55.0,
    fontFamily: 'Signatra',

  );
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Google Map
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  DirectionDetails tripDirectionDetails;

  

  //polyline
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polyLineSet = {};


  //Get User Current Location

  Position currentPosition;

  var geolocator = Geolocator();
  double bottomPaddingOfMap = 0;


  Set<Marker> marketSet = {};
  Set<Circle> circleSet = {};

  double rideDetailsContainer = 0;
  double requestRideDetailsContainer = 0;
  double searchContainerHeight = 300.0;
  double driverDetailsContainer =0.0;

  bool drawerOpen = true;
  bool nearByAvailableCleanerKeysLoaded = false;

  DatabaseReference rideRequestRef;
  BitmapDescriptor nearByIcon;

  List<NearByCleaners> availableCleaners;
  String state ="normal";
  String uName="";
  StreamSubscription<Event> rideStreamSubcription ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AssistantMethods.getCurrentOnlineUserInfo();
  }

  void saveRideRequest()
  {
   rideRequestRef = FirebaseDatabase.instance.reference().child("Ride Requests").push();

   var pickUp = Provider.of<AppData>(context, listen: false).pickUpLocation;
   var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;


   Map pickUpLocMap =
   {
    "latitude" :pickUp.latitude.toString(),
     "longitude" :pickUp.longitude.toString(),

   };
   Map dropOffLocMap =
   {
     "latitude" :dropOff.latitude.toString(),
     "longitude" :dropOff.longitude.toString(),

   };

   Map rideInfoMap =
   {
     "driver_id": "waiting",
     "payment_method" : "cash",
     "pickup" : pickUpLocMap,
     "dropoff": dropOffLocMap,
     "created_at" : DateTime.now().toString(),
     "rider_name": currentUserInfo.name,
     "rider_phone": currentUserInfo.phone,
     "pickup_address": pickUp.placeName,
     "dropoff_address": dropOff.placeName,

     


   };
   
   rideRequestRef.set(rideInfoMap);

   rideStreamSubcription = rideRequestRef.onValue.listen((event) async {
     if(event.snapshot.value == null )
     {
           return;
     }

     if(event.snapshot.value["cleaner_name"] != null)
     {

       setState(() {
         cleaner_name = event.snapshot.value["cleaner_name"].toString();
       });


     }

     if(event.snapshot.value["cleaner_phone"] != null)
     {

       setState(() {
         cleaner_phone = event.snapshot.value["cleaner_phone"].toString();
       });


     }

     if(event.snapshot.value["status"] != null)
       {
         Statusride = event.snapshot.value["status"].toString();

       }
     if(Statusride == "accepted")
       {
         displayDriverDetailsContainer();
         Geofire.stopListener();
         deleteGeofileMarkers();
       }

     if(Statusride == "ended")
     {
       if(event.snapshot.value["fares"] != null)
       {
         int fare = int.parse(event.snapshot.value["fares"].toString());
         var res = await showDialog(
           context: context,
           barrierDismissible: false,
           builder: (BuildContext context)=> CollectFareDialog(paymentMethod: "cash", fareAmount: fare,),
         );

         String driverId="";
         if(res == "close")
         {
           if(event.snapshot.value["driver_id"] != null)
           {
             driverId = event.snapshot.value["driver_id"].toString();
           }

           Navigator.of(context).push(MaterialPageRoute(builder: (context) => RatingScreen(driverId: driverId)));

           rideRequestRef.onDisconnect();
           rideRequestRef = null;
           rideStreamSubcription.cancel();
           rideStreamSubcription = null;
           restApp();
         }
       }
     }

   });

  }

  void deleteGeofileMarkers()
  {
    setState(() {
      marketSet.removeWhere((element) => element.markerId.value.contains("driver"));
    });
  }

  void cancelRequest ()
  {
    rideRequestRef.remove();
    setState(() {
      state="normal";
    });
  }
  void displayRequestRideContainer()
  {
    setState(() {
      requestRideDetailsContainer = 250;
      rideDetailsContainer = 0;
      bottomPaddingOfMap = 230.0;
      drawerOpen = true;
    });
    saveRideRequest();
  }


  void displayDriverDetailsContainer()
  {

   setState(() {
     requestRideDetailsContainer = 0.0;
     rideDetailsContainer = 0.0;
     bottomPaddingOfMap = 290.0;
     driverDetailsContainer=320.0;
   });

  }

  restApp()
  {
    setState(() {
      drawerOpen = true;
    searchContainerHeight = 300;
    rideDetailsContainer = 0;
    bottomPaddingOfMap = 230.0;
    requestRideDetailsContainer =0;

    polyLineSet.clear();
    marketSet.clear();
    circleSet.clear();
    pLineCoordinates.clear();

    });

    locatePosition();
  }

 void displayRideDetailsContainer () async
 {
    await getPlaceDirection();

    setState(() {
        searchContainerHeight = 0;
        rideDetailsContainer = 250.0;
        bottomPaddingOfMap = 230.0;
        drawerOpen = false;
    });
 }

  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(
        target: latLatPosition, zoom: 15);

    newGoogleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(
        position, context);

    print("This is your Address:" + address);

    initGeoFireListner();

    uName = currentUserInfo.name;

    AssistantMethods.retrieveHistoryInfo(context);
  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  @override
  Widget build(BuildContext context) {
    createIconMarker();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff000093),
        title: Text("FOLAJ DRY CLEANING"),
      ),

      drawer: Container(

        color: Colors.white,
        width: 225.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer header

              Container(
                height: 165.0,
                child: DrawerHeader(

                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user_icon.png", height: 65.0, width: 65.0,),

                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(uName, style: TextStyle(
                              fontSize: 16.0, fontFamily: "Brand-Bold"),),
                          SizedBox(height: 6.0,),
                          GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileTabPage()));
                              },
                              child: Text("Visit Profile")
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              DividerWidget(),

              SizedBox(height: 12.0,),

              //Drawer Body

              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text("History", style: TextStyle(fontSize: 15.0),),
                ),
              ),

              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ServicesScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.local_laundry_service_outlined),
                  title: Text("Services", style: TextStyle(fontSize: 15.0),),
                ),
              ),


              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutScreen()));
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About", style: TextStyle(fontSize: 15.0),),
                ),
              ),


              GestureDetector(
                onTap: ()
                {
                   FirebaseAuth.instance.signOut();
                   Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Sign Out", style: TextStyle(fontSize: 16.0),),

                ),
              )


            ],
          ),
        ),

      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            markers: marketSet,
            circles: circleSet,
            polylines: polyLineSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });
              locatePosition();
            },
          ),


          //Hamburgers for Drawer


          Positioned(

            top: 38.0,
            left: 22.0,

            child: GestureDetector(
              onTap: () {
                if(drawerOpen)
                {
                  scaffoldKey.currentState.openDrawer();
                }
                else
                  {
                    restApp();
                  }
              },
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 6.0,
                          spreadRadius: 0.5,

                          offset: Offset(
                            0.7,
                            0.7,

                          )

                      )
                    ]
                ),

                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(( drawerOpen  )? Icons.menu : Icons.close, color: Colors.black,),
                  radius: 20.0,
                ),
              ),
            ),
          ),
             //Search Ui


          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,

            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: searchContainerHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),

                      )
                    ]

                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 6.0,),
                      Text("Hi There , ", style: TextStyle(fontSize: 12),),
                      Text("Way to Folaj Dry Cleaning Office? ", style: TextStyle(
                          fontSize: 20, fontFamily: "Brand-Bold"),),

                      SizedBox(height: 20.0,),

                      GestureDetector(

                        onTap: () async
                        {
                          var res = await Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => SearchScreen()));

                          if (res == "obtainDirection") {
                            displayRideDetailsContainer();
                          }
                        },
                        child: Container(

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7),

                                )
                              ]

                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [

                                Icon(Icons.search, color: Colors.blueAccent,),
                                SizedBox(width: 10.0,),
                                Text("Search For Folaj Dry Cleaning Office",
                                  style: TextStyle(fontSize: 12),)
                              ],
                            ),
                          ),


                        ),
                      ),

                      SizedBox(height: 24.0,),
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.grey,),
                          SizedBox(height: 12.0,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                  Provider
                                      .of<AppData>(context)
                                      .pickUpLocation != null
                                      ? Provider
                                      .of<AppData>(context)
                                      .pickUpLocation
                                      .placeName
                                      : "Add Home"
                              ),
                              SizedBox(height: 4.0,),
                              Text("Your Residential Home Address",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 12.0),)

                            ],
                          )
                        ],
                      ),

                      SizedBox(height: 10.0,),

                      DividerWidget(),

                      SizedBox(height: 16.0,),

                      Row(
                        children: [
                          Icon(Icons.work, color: Colors.grey,),
                          SizedBox(height: 12.0,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text("Add Work"),
                              SizedBox(height: 4.0,),
                              Text("Your Office Address", style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),)

                            ],
                          )
                        ],
                      ),


                    ],
                  ),
                ),

              ),
            ),


          ),

          //Ride Details UI
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainer,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7, 0.7
                      )

                    ),

                  ]
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric( vertical: 17.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.tealAccent[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),

                          child: Row(
                            children: [
                              Image.asset("images/bg.png", height: 70.0, width: 80.0,),

                              SizedBox(width: 16.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Laundry", style: TextStyle(
                                    fontSize: 18.0, fontFamily: "Brand-Bold"
                                  ),
                                  ),
                                    Text(
                                      ((tripDirectionDetails != null )? tripDirectionDetails.distanceText :''), style: TextStyle(
                                        fontSize: 18.0, color: Colors.grey
                                    ),
                                    )
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),

                              // Text(
                              //   (( tripDirectionDetails != null) ? 'Calc. TP.: \#${AssistantMethods.calculateFares(tripDirectionDetails)}' : ''), style: TextStyle(
                              //     fontFamily: "Brand-Bold", fontSize: 12, fontWeight: FontWeight.bold
                              // ),
                              // ),

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16.0,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),

                        child: Row(
                          children: [
                                  Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black54,),
                                   SizedBox(width: 16.0,),
                                   Text("Cash"),
                                   SizedBox(width: 6.0,),
                                   Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 16.0,),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.0,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: RaisedButton(
                          onPressed: ()
                          {
                            setState(() {
                              state ="requesting";
                            });
                          displayRequestRideContainer();
                          availableCleaners  = GeoFireAssistant.nearbycleanersList;
                          searchAvailableCleaners();
                          },
                          color: Theme.of(context).accentColor,

                          child: Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text("Request for Dry Cleaning Service", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                Icon(FontAwesomeIcons.rocketchat, color: Colors.white, size: 18.0,),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),


          //Request or Cancel UI
          Positioned(
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            child: Container(
              decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                   color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.5,
                    blurRadius: 16.0,
                    color: Colors.black54,
                    offset: Offset(0.7, 0.7),

                  )
                ]
              ),
              height: requestRideDetailsContainer,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox( height: 12.0,),




                      SizedBox(
                         width: double.infinity,
                            child: AnimatedTextKit(
                              animatedTexts: [
                                 ColorizeAnimatedText(
                                  'Requesting.....',
                                    textStyle: colorizeTextStyle,
                                       colors: colorizeColors,
                                   textAlign: TextAlign.center
                                        ),
                                      ColorizeAnimatedText(
                                           'Folaj Laundry Service..',
                                               textStyle: colorizeTextStyle,
                                               colors: colorizeColors,
                                                    textAlign: TextAlign.center
                                                   ),
                                                 ColorizeAnimatedText(
                                                    'Please wait......',
                                                   textStyle: colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      textAlign: TextAlign.center
                                                         ),
                                                       ],
                                                   isRepeatingAnimation: true,
                                     onTap: () {
                                          print("Tap Event");
                                                 },
                                         ),
                                 ),

                    SizedBox( height:  22.0,),

                    GestureDetector(
                      onTap: (){
                        cancelRequest();
                        restApp();
                      },
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(width: 2.0, color: Colors.grey[300]),
                        ),
                        child: Icon(Icons.close, size: 26.0,),

                      ),
                    ),
                    SizedBox( height:  10.0,),

                    Container(
                      width: double.infinity,

                      child: Text("Cancel Request", textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0),),
                    )
                  ]
                ),
              )
            ),
          ),

          //Assign Cleaner Info UI
          Positioned(
             bottom: 0.0,
             left: 0.0,
            right: 0.0,

            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 16.0,
                      color: Colors.black54,
                      offset: Offset(0.7, 0.7),

                    )
                  ]
              ),
                height: driverDetailsContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       SizedBox(height: 6.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Laundry is Coming", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontFamily: "Brand-Bold"),),
                          ],
                        ),
                        SizedBox(height: 22.0,),

                        Divider(height: 2.0, thickness: 2.0,),

                        Text(cleaner_name, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),

                        SizedBox(height:5.0),
                        Text(cleaner_phone, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),

                        SizedBox(height: 22.0),

                        Divider(height: 2.0, thickness: 2.0, ),

                        SizedBox(height: 22.0,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //call button
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(24.0),
                                ),
                                onPressed: () async
                                {
                                  launch(('tel://${cleaner_phone}'));
                                },
                                color: Colors.black87,
                                child: Padding(
                                  padding: EdgeInsets.all(17.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Call Laundry   ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                      Icon(Icons.call, color: Colors.white, size: 26.0,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


                      ]
                  ),
                )
            ),

          ),
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async
  {
    var initialPos = Provider
        .of<AppData>(context, listen: false)
        .pickUpLocation;
    var finalPos = Provider
        .of<AppData>(context, listen: false)
        .dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);


    showDialog(
        context: context,
        builder: (BuildContext context) =>
            progressDialog(message: "Please wait.......",)
    );

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);
     setState(() {
       tripDirectionDetails = details;
     });

    Navigator.pop(context);

    print("This is the Encoded ::");
    print(details.encodedPoint);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolylineResult = polylinePoints.decodePolyline(
        details.encodedPoint);

    pLineCoordinates.clear();
    if (decodedPolylineResult.isNotEmpty) {
      decodedPolylineResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates.add(
            LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polyLineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,


      );

      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    }
    else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    }
    else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    }
    else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }
    newGoogleMapController.animateCamera(
        CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(
            title: initialPos.placeName, snippet: "My Location"),
        position: pickUpLatLng,
        markerId: MarkerId("pickUpId")

    );

    Marker dropOffLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
            title: finalPos.placeName, snippet: "Laundry Location"),
        position: dropOffLatLng,
        markerId: MarkerId("LaundryId")

    );

    setState(() {
      marketSet.add(pickUpLocMarker);
      marketSet.add(dropOffLocMarker);
    });


    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blue,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blue,
      circleId: CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: CircleId("laundryId"),
    );

    setState(() {
      circleSet.add(pickUpLocCircle);
      circleSet.add(dropOffLocCircle);

    });
  }

  void initGeoFireListner() {
    Geofire.initialize("availableCleaners");
    Geofire.queryAtLocation(currentPosition.latitude, currentPosition.longitude, 35).listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearByCleaners nearByCleaners =  NearByCleaners();
            nearByCleaners.key = map['key'];
            nearByCleaners.latitude = map['latitude'];
            nearByCleaners.longitude = map['longitude'];

            GeoFireAssistant.nearbycleanersList.add(nearByCleaners);
             if(nearByAvailableCleanerKeysLoaded == true)
               {
                 updateAvailableCleanersOnMap();
               }
            break;

          case Geofire.onKeyExited:
            GeoFireAssistant.removeCleanerFromList(map['key']);
            updateAvailableCleanersOnMap();
            break;

          case Geofire.onKeyMoved:
            NearByCleaners nearByCleaners =  NearByCleaners();
            nearByCleaners.key = map['key'];
            nearByCleaners.latitude =map['latitude'];
            nearByCleaners.longitude = map['longitude'];

            GeoFireAssistant.updateCleanerNearByLocation(nearByCleaners);
            updateAvailableCleanersOnMap();
            break;

          case Geofire.onGeoQueryReady:
          updateAvailableCleanersOnMap();


            break;
        }
      }

      setState(() {});
    });
  }

 void updateAvailableCleanersOnMap()
  {
    setState(() {
      marketSet.clear();
    });
 Set<Marker> tMakers = Set<Marker>();

 for(NearByCleaners cleaner in GeoFireAssistant.nearbycleanersList)
   {
     LatLng cleanerAvailablePosition = LatLng(cleaner.latitude, cleaner.longitude);
     
     Marker marker = Marker(
       markerId: MarkerId('cleaner${cleaner.key}'),
       position: cleanerAvailablePosition,
       icon: nearByIcon,
       rotation: AssistantMethods.createRandomNumber(360),


     );
          tMakers.add(marker);
   }

 setState(() {
   marketSet = tMakers;
 });

  }


  void createIconMarker()
  {
    if(nearByIcon == null)
      {
        ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: Size(1, 1));
        BitmapDescriptor.fromAssetImage(imageConfiguration, "images/cloo.jpeg" )
            .then((value) {
          nearByIcon = value;
        });
      }
  }


  void noCleanerFound()
  {
    showDialog(
       context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => NoCleanerAvailable()
    );
  }
  void searchAvailableCleaners()
  {
       if( availableCleaners.length == 0 )
       {
         cancelRequest();
         restApp();
          noCleanerFound();
          return;
       }


       var driver = availableCleaners[0];
       availableCleaners.removeAt(0);
       notifyNearByCleaner(driver);
  }

  void notifyNearByCleaner( NearByCleaners cleaner)
  {
        driversRef.child(cleaner.key).child("newRide").set(rideRequestRef.key);

        driversRef.child(cleaner.key).child("token").once().then((DataSnapshot snapshot) {

          if( snapshot.value != null)
            {
              String token = snapshot.value.toString();
              AssistantMethods.sendNotification(token, context, rideRequestRef.key);
            }
          else
            {
              return;
            }

          const oneSecondPassed = Duration(seconds: 1);
          var timer = Timer.periodic(oneSecondPassed, (timer) {

            if(state != "requesting")
              {
                driversRef.child(cleaner.key).child("newRide").set("cancelled");
                driversRef.child(cleaner.key).child("newRide").onDisconnect();
                driversRequestTimeOut = 20;
                timer.cancel();
              }
            driversRequestTimeOut = driversRequestTimeOut - 1;
            driversRef.child(cleaner.key).child("newRide").onValue.listen((event) {

              if(event.snapshot.value.toString() == "accepted")
                {
                  driversRef.child(cleaner.key).child("newRide").onDisconnect();
                  driversRequestTimeOut = 20;
                  timer.cancel();
                }
            });


            if( driversRequestTimeOut == 0)
              {
                driversRef.child(cleaner.key).child("newRide").set("timeout");
                driversRef.child(cleaner.key).child("newRide").onDisconnect();
                driversRequestTimeOut = 20;
                timer.cancel();

                searchAvailableCleaners();
              }

          });

        });
  }
}