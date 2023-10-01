import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screen/login.dart';

Future<void> getDocumentID() async{

}

Future<void> AddUser(name,email,carNumber, mobileNumber, countryCode, {required BuildContext context})async{
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  return user.add({

    'Name': name.text,
    'Email': email.text,
    'Car Number': carNumber.text,
    'Mobile Number':mobileNumber.text,
    'country Code':countryCode,
  })
      .then((value) => Navigator.of(context).push( MaterialPageRoute(builder: (context) =>  const Login())))
      .catchError((error) => print(error));
}
