import 'package:flutter/material.dart';

class FullServicesScreen extends StatefulWidget {
  static const String idScreen = "fullservices";

  @override
  _FullMyServicesScreenState createState() => _FullMyServicesScreenState();
}

class _FullMyServicesScreenState extends State<FullServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff5591f),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
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
                      margin: const EdgeInsets.only(top: 10),
                      child: Image.asset("assets/images/small.png"),
                      height: 150,
                      width: double.infinity,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Our Serices",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //1st services

            Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(
                left: 10,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(
                  left: 5,
                ),
                leading: const Icon(
                  Icons.dry_cleaning,
                  color: Colors.orange,
                  size: 30,
                ),
                title: const Text(
                  "Wash :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                subtitle: Text('We wash your cloth and deliver on time.'),
                onTap: () => {},
              ),
            ),

            //2nd services
            Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(
                left: 10,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              child: ListTile(
                enableFeedback: true,
                contentPadding: const EdgeInsets.only(
                  left: 5,
                ),
                leading: const Icon(
                  Icons.dry_cleaning,
                  color: Colors.orange,
                  size: 30,
                ),
                title: const Text(
                  "Iron :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                subtitle: Text(
                    'You take care of the washing,\n We just iron them for you.'),
                onTap: () => {},
              ),
            ),

            //3rd services

            Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(
                left: 10,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(
                  left: 5,
                ),
                leading: const Icon(
                  Icons.dry_cleaning,
                  color: Colors.orange,
                  size: 30,
                ),
                title: const Text(
                  "Dry Cleaning :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                subtitle: Text('Cleaned and Dried Laundry.'),
                onTap: () => {},
              ),
            ),

            //3rd services

            Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(
                left: 10,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(
                  left: 5,
                ),
                leading: const Icon(
                  Icons.dry_cleaning,
                  color: Colors.orange,
                  size: 30,
                ),
                title: const Text(
                  "Wash and Iron :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                subtitle: Text(
                    'Everyday laundry ironed after\ndrying and put on hangers.'),
                onTap: () => {},
              ),
            ),

            //4th services
          ],
        ),
      ),
    );
  }
}
