/*
عشان اتعلم بس
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/Screen/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screen/homepage.dart';

Future<void> addUser(name, email, carNumber, mobileNumber, countryCode,
    {required BuildContext context}) async {
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  bool result = await FirebaseFirestore.instance
      .collection('user')
      .where('Mobile Number', isEqualTo: mobileNumber.text.toString())
      .get()
      .then((value) => value.size > 0 ? true : false);
  if (result == false) {
    return user
        .add({
          'Name': name.text,
          'Email': email.text,
          'Car Number': carNumber.text,
          'Mobile Number': mobileNumber.text,
          'country Code': countryCode,
        })
        .then((value) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login())))
        .catchError((error) => print(error));
  } else {
    mobileNumber.text = '';
    print("the phone number is already exists");
  }
}

Future login(mobileNumber, {required BuildContext context}) async {
  bool result = await FirebaseFirestore.instance
      .collection('user')
      .where('Mobile Number', isEqualTo: mobileNumber.text.toString())
      .get()
      .then((value) => value.size > 0 ? true : false);

  if (result == true) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  } else {
    mobileNumber.text = '';
    print("inc password");
  }
}

Future updateUser(
    name,
    email,
    mobileNumber,
    carNumber,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController mobileNumberController,
    TextEditingController carNumberController,
    documentID) async {
  ;
  FirebaseFirestore.instance.collection('user').doc(documentID).update({
    'Name': nameController.text.isEmpty ? name : nameController.text,
    'Email': emailController.text.isEmpty ? email : emailController.text,
    'Mobile Number': mobileNumberController.text.isEmpty
        ? mobileNumber
        : mobileNumberController.text,
    'Car Number':
        carNumberController.text.isEmpty ? carNumber : carNumberController.text
  }).then((value) async {
    SharedPreferences signUpUser = await SharedPreferences.getInstance();
    signUpUser.setString(
      'mobileNumber',
      mobileNumberController.text.isEmpty
          ? mobileNumber
          : mobileNumberController.text,
    );
    signUpUser.setString(
        'name', nameController.text.isEmpty ? name : nameController.text);
    signUpUser.setString(
        'email', emailController.text.isEmpty ? email : emailController.text);
    signUpUser.setString(
        'carNumber',
        carNumberController.text.isEmpty
            ? carNumber
            : carNumberController.text);
  }).catchError((error) => print(error));
}
