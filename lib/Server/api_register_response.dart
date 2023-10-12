import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screen/login.dart';

void FetchRegister(name, email, password,  mobileNumber,countryCode,
    {required BuildContext context}) async {
  SharedPreferences sharedtoken = await SharedPreferences.getInstance();
  Map<String, String> header = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };
  final msg = jsonEncode({
    "name": name.text,
    "mobile": countryCode.toString() + mobileNumber.text.toString(),
    "email": email.text,
    "password": password.text,
    "account_type": 1,
  });

  final response = await http.post(
    Uri.parse('https://news.wasiljo.com/public/api/v1/user/register'),
    headers: header,
    body: msg,
  );

  var data = json.decode(response.body);
  if (response.statusCode == 200) {
    sharedtoken.setString('token', data['data']['token']);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Login()));
  } else {
    throw Exception('Failed to load register');
  }
}
