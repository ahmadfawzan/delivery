
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screen/signup.dart';

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
  print(data);
  if (response.statusCode == 200) {
    await sharedtoken.clear();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUp()));
  } else {
    throw Exception('Failed to load Login');
  }
}