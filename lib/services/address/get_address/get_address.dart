import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/address_model/address_model.dart';

class RemoteServicesAddress {
  static Future<List<Address>> fetchAddress() async {
    SharedPreferences sharedtoken = await SharedPreferences.getInstance();
    String? token = sharedtoken.getString('token');
    final response = await http.get(
      Uri.parse('https://news.wasiljo.com/public/api/v1/user/addresses'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      return addressFromJson(data['data']['addresses']);
    } else {
      throw Exception(data['error']);
    }
  }
}
