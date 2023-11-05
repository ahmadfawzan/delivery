import 'package:get/get.dart';
import '../../controllers/shop_controller/shop_controller.dart';
import '../../models/item_shop_model/item_shop_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class RemoteServicesItemShop {
  static Future<List<ItemShop>> fetchItemShop() async {
    final ShopController shopController = Get.find();
    final response = await http.get(
      Uri.parse(
          'https://news.wasiljo.com/public/api/v1/user/shops/${shopController.id}/subcategory'),
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
     return itemShopFromJson(data['data']['sub_categories']);
    } else {
      throw Exception('${data['error']}');
    }
  }
}
