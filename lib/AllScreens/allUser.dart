import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class Users
{
  String id;
  String name;
  String email;
  String phone;


  Users({this.phone, this.name, this.id, this.email});

  Users.fromSnapshot(DataSnapshot dataSnapshot)
  {
     id = dataSnapshot.key;
     email = dataSnapshot.value["email"];
     name = dataSnapshot.value["name"];
     phone = dataSnapshot.value["phone"];
}
}