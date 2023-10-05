import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Utils/Helper/list_data_categories_api.dart';
Future<List<Categories>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://news.wasiljo.com/public/api/v1/user/categories'));

    if (response.statusCode == 200) {
      return compute(getCategories, response.body);
   } else {
    throw Exception('Failed to load Categories');
  }

}

List<Categories> getCategories(String responseBody) {
  var data = jsonDecode(responseBody);
  return data['data']['categories'].map<Categories>((json) => Categories.fromJson(json)).toList();
}
