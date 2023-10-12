import 'dart:convert';
import 'package:delivery/Screen/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future FetchLogin(mobileNumber, countryCode, password,
    {required BuildContext context}) async {
  SharedPreferences sharedtoken = await SharedPreferences.getInstance();
  Map<String, String> header = {
    'Accept-Language': 'application/json',
    'Access-Control-Request-Headers': 'application/json',
  };
  final response = await http.post(
    Uri.parse('https://news.wasiljo.com/public/api/v1/user/login'),
    headers: header,
    body: {
      "mobile": '${countryCode + mobileNumber.text}',
      "password": password.text,
    },
  );
  var data = json.decode(response.body);
  if (response.statusCode == 200) {
    sharedtoken.setString('token', data['data']['token']);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  } else {
    throw Exception('Failed to load Login');
  }
}
