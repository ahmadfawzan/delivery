import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../controllers/checkout_controller/checkout_controller.dart';
import '../../../widgets/text_widgets.dart';

Future PostLogin(mobileNumber, countryCode, password,
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
    final CheckOutController checkOutController = Get.put(CheckOutController(),permanent: true);
    sharedtoken.setString('token', data['data']['token']);
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: data['data']['token']);
    if (!context.mounted) return;
    Get.offAllNamed('/home');
    checkOutController.phoneNumber ='${countryCode + mobileNumber.text}';
  } else {
    if (!context.mounted) return;
    AwesomeDialog(
      animType: AnimType.leftSlide,
      dialogType: DialogType.error,
      btnOkOnPress: () {},
      context: context,
      title: 'Error',
      body: TextWidgets(
        text: '${data['error']}',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    ).show();
  }
}
