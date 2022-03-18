import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var firestoreDb = FirebaseFirestore.instance
      .collection("Orders")

      //remove this line if you want the admin to see all ordeer
      .where('senderUid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff5591f),
        title: Text('Order History'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestoreDb,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 1, right: 1, top: 5),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 0,
                          color: Colors.blueGrey,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: Colors.grey[200],
                          leading: Icon(Icons.restore_rounded),
                          trailing: Text(
                            snapshot.data.docs[index]['date'],
                            style: TextStyle(fontSize: 12),
                          ),

                          title: Text(
                              'Order Number : ' +
                                  snapshot.data.docs[index]['orderId'],
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          // subtitle: Text(snapshot.data.docs[index]['location']),
                          subtitle: Text(
                            'Sent Successfully',
                            style: TextStyle(color: Colors.green, fontSize: 13),
                          ),
                          minLeadingWidth: 5,
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
