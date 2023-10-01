import 'package:delivery/Screen/about_us.dart';
import 'package:delivery/Screen/login.dart';
import 'package:delivery/Screen/signup.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Server/firebase_auth.dart';

Future localStorageSignUpUser(TextEditingController name,TextEditingController email,TextEditingController carNumber,
    String nameImage, String nameImage1,TextEditingController mobileNumber
    ,TextEditingController password,String dropDownValue, String countryCode, {required BuildContext context}) async {

  SharedPreferences signUpUser = await SharedPreferences.getInstance();
  signUpUser.setString('name', name.text);
  signUpUser.setString('email', email.text);
  signUpUser.setString('carNumber', carNumber.text);
  signUpUser.setString('nameImage', nameImage);
  signUpUser.setString('nameImage1', nameImage1);
  signUpUser.setString('mobileNumber', mobileNumber.text);
  signUpUser.setString('Password1', password.text);
  signUpUser.setString('dropDownValue', dropDownValue);
  signUpUser.setString('countryCode', countryCode);
  String? getName = signUpUser.getString('name');
  String? getEmail = signUpUser.getString('email');
  String? getCarNumber = signUpUser.getString('carNumber');
  String? getNameImage = signUpUser.getString('nameImage');
  String? getNameImage1 = signUpUser.getString('nameImage1');
  String? getDropDownValue = signUpUser.getString('dropDownValue');
  String? getMobileNumber = signUpUser.getString('mobileNumber');
  String? getPassword = signUpUser.getString('Password1');
  String? getCountryCode = signUpUser.getString('countryCode');


  if(getNameImage1!.isNotEmpty && getNameImage!.isNotEmpty && getCarNumber!.isNotEmpty && getEmail!.isNotEmpty && getName!.isNotEmpty && getMobileNumber!.isNotEmpty && getPassword.toString().isNotEmpty && getDropDownValue!.isNotEmpty &&  getCountryCode!.isNotEmpty)
  {

    addUser(name,email,carNumber,mobileNumber,countryCode,context:context);

  }
  else
  {
    Navigator.of(context).push( MaterialPageRoute(builder: (context) =>  const SignUp()));


  }
}

Future localStorageLoginUser(TextEditingController mobileNumber,TextEditingController password,
    String countryCode,{required BuildContext context}) async {

  SharedPreferences signUpUser = await SharedPreferences.getInstance();
  signUpUser.setString('mobileNumber', mobileNumber.text);
  signUpUser.setString('Password1', password.text);
  signUpUser.setString('countryCode', countryCode);
  String? getMobileNumber = signUpUser.getString('mobileNumber');
  String? getPassword = signUpUser.getString('Password1');
  String? getCountryCode = signUpUser.getString('countryCode');

  if(getMobileNumber!.isNotEmpty && getPassword.toString().isNotEmpty && getCountryCode!.isNotEmpty)
  {

    login(mobileNumber,countryCode,context:context);

  }
  else
  {
    Navigator.of(context).push( MaterialPageRoute(builder: (context) =>  const Login()));


  }
}



Future localStorageCheck({required BuildContext context}) async{

  SharedPreferences signUpUser = await SharedPreferences.getInstance();
  String? getMobileNumber = signUpUser.getString('mobileNumber') ??"";
  String? getPassword = signUpUser.getString('Password1') ??"";
  String? getCountryCode = signUpUser.getString('countryCode') ??"";

  if(getMobileNumber.isNotEmpty && getPassword.toString().isNotEmpty && getCountryCode.isNotEmpty)
  {
    Navigator.of(context).push( MaterialPageRoute(builder: (context) =>  const AboutUs()));

  }
  else
  {

    Navigator.of(context).push( MaterialPageRoute(builder: (context) =>   const SignUp()));

  }

}
