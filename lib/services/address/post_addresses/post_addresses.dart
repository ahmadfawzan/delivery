import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/text_widgets.dart';

Future postDataAddresses(
    lat, long, selectedOption, city, street, name, buildingNumber, apartmentNum,
    {required BuildContext context}) async {
  SharedPreferences sharedtoken = await SharedPreferences.getInstance();
  String? token = sharedtoken.getString('token');
  final response = await http.post(
    Uri.parse('https://news.wasiljo.com/public/api/v1/user/addresses'),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: {
      "longitude": long.toString(),
      "latitude": lat.toString(),
      "street": street.toString(),
      "city": city.toString(),
      "apartment_num": apartmentNum.text.toString(),
      "type": selectedOption.toString(),
      "name": name.toString(),
      "building_number": buildingNumber.text.toString(),
    },
  );
  var data = json.decode(response.body);

  if (response.statusCode == 200) {
    if (!context.mounted) return;
    AwesomeDialog(
      animType: AnimType.leftSlide,
      dialogType: DialogType.success,
      btnOkOnPress: () {},
      context: context,
      title: 'Success',
      body: const TextWidgets(
        text: 'The address has been added successfully',
        textAlign: TextAlign.center,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ).show();
  } else {
    if (!context.mounted) return;
    AwesomeDialog(
      animType: AnimType.leftSlide,
      dialogType: DialogType.error,
      btnOkOnPress: () {},
      context: context,
      title: 'Error',
      body: TextWidgets(
        text: '${data['error'].map((item) => item.toString())}',
      ),
    ).show();
  }
}


