import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/categorie_model/categorie_model.dart';
class RemoteServicesCategorie{
 static Future <List<Categorie>> fetchCategorie() async {
  final response = await http.get(Uri.parse('https://news.wasiljo.com/public/api/v1/user/categories'));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return categorieFromJson(data['data']['categories']);
  } else {
    throw Exception(data['error']);
  }
}
}