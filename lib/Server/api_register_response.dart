
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void FetchSingUp(name,email,carNumber,password,mobileNumber, countryCode, {required BuildContext context}) async {
  final response = await http.post(Uri.parse('https://news.wasiljo.com/public/api/v1/user/register'),
  headers: {
    'Accept': 'application/json',
     'Content-Type': 'application/json'
  },
  body: {
    "name":"$name",
    "mobile":"${countryCode + mobileNumber}",
    "password":"$password",
    "email":"$email",
    "account_type":"$carNumber",
  }
  );
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
  print(data['token']);
  } else {
    throw Exception('Failed to load Categories');
  }

}
