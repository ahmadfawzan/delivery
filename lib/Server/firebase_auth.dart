import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/Screen/about_us.dart';
import 'package:flutter/material.dart';
import '../Screen/login.dart';


Future<void> addUser(name,email,carNumber, mobileNumber, countryCode, {required BuildContext context})async{
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




login(mobileNumber , countryCode,{required BuildContext context}) async {
  bool result =await FirebaseFirestore.instance.collection('user')
      .where('Mobile Number', isEqualTo: mobileNumber.text.toString())
      .where('country Code', isEqualTo: countryCode)
      .get().then((value) => value.size > 0 ? true : false );

  if(result == true){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
  }else{
    mobileNumber.text = '';
    print("inc password");
  }
}