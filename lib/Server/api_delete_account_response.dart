
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screen/signup.dart';
import '../Utils/Ui/text_widgets.dart';

Future DeleteAccount({required BuildContext context}) async {
  SharedPreferences sharedtoken  = await SharedPreferences.getInstance();
  String? token = sharedtoken.getString('token');
  final response = await http.post(
    Uri.parse('https://news.wasiljo.com/public/api/v1/user/delete'),
    headers: {
      'Authorization': 'Bearer $token',
    },

  );

  var data = json.decode(response.body);
  if (response.statusCode == 200) {
    await sharedtoken.clear();


    AwesomeDialog(
      animType: AnimType.leftSlide,
      dialogType: DialogType.success,
      btnOkOnPress: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUp()));},
      context: context,

      title: 'Success',
      body: TextWidgets(
        text: '${data['message']} Click OK to go to the page SignUp',textAlign:TextAlign.center, fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ).show();

  } else {
    throw Exception('Failed to load Login');
  }
}