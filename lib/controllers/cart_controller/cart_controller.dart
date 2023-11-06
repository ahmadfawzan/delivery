import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  RxList itemCart = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  RxInt numberOfItem = 0.obs;
  RxList<int> counter = <int>[].obs;
  RxList<Map<String, dynamic>?> itemsList = <Map<String, dynamic>?>[].obs;

  void addItemToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? savedItems;
    if (itemCart.isNotEmpty) {
      prefs.setStringList(
          'cartItems', itemCart.map((item) => json.encode(item)).toList());
      savedItems = prefs.getStringList('cartItems');
      numberOfItem.value = savedItems!.length;
      itemsList.value = savedItems.map((item) {
        try {
          isLoading.value = false;
          return json.decode(item) as Map<String, dynamic>;
        } catch (e) {
          return null;
        }
      }).toList();
      update();
    } else {
      savedItems = prefs.getStringList('cartItems');
      numberOfItem.value = savedItems!.length;
      if (savedItems.isNotEmpty) {
        itemsList.value = savedItems.map((item) {
          try {
            isLoading.value = false;
            return json.decode(item) as Map<String, dynamic>;
          } catch (e) {
            return null;
          }
        }).toList();
      }
      update();
    }

  }
  void increment(int index) {
    counter[index]++;
    update();
  }

  void decrement(int index) {
    if (counter[index] > 0) {
      counter[index]--;
      update();
    }
  }

}
