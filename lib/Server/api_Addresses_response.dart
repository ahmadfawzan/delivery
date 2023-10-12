import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future postDataAddresses(lat, long, selectedOption, city, street, name,
    buildingNumber, apartmentNum) async {
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

  if (response.statusCode == 200) {
    print("Save is Done");
  } else {
    throw Exception('Failed to load Addresses');
  }
}
