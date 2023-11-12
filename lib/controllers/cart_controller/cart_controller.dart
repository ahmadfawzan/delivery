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
    List<String>? savedItems;
    if (itemCart.isNotEmpty) {
      prefs.setStringList('cartItems', itemCart.map((item) => json.encode(item)).toList());
      savedItems = prefs.getStringList('cartItems');
      numberOfItem.value = savedItems?.length ?? 0;
      itemsList.value = savedItems!.map((item) {
        try {
          isLoading.value = false;
          return json.decode(item) as Map<String, dynamic>;
        } catch (e) {
          return null;
        }finally{update();}
      }).toList();

    } else {
      savedItems = prefs.getStringList('cartItems');
      numberOfItem.value = savedItems?.length ?? 0;
      if (savedItems != null && savedItems.isNotEmpty) {
        itemsList.value = savedItems.map((item) {
          try {
            isLoading.value = false;
            return json.decode(item) as Map<String, dynamic>;
          } catch (e) {
            return null;
          }finally{update();}
        }).toList();
      }
    }

  }
  void increment(int index) {
    counter[index]++;
    update();
  }

  void decrement(int index) {
    if (counter[index] > 1) {
      counter[index]--;
      update();
    }
  }

  double calculateOneItems(int index) {
    if (index < 0 || index >= counter.length || index >= itemsList.length) {
      return 0;
    }
    double total = 0;
    total += counter[index] * (itemsList[index]?['price']??0);
    return total;
  }


  double calculateTotal() {
    double total = 0;
    for (int i = 0; i < counter.length && i < itemsList.length; i++) {
      total += counter[i] * (itemsList[i]?['price'] ?? 0);
    }
    return total;
  }

  Future<void> saveCounterValues() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('counter', counter.map((value) => value.toString()).toList());
    update();
  }

  Future<void> retrieveCounterValues() async {
    final prefs = await SharedPreferences.getInstance();
    final counterStrings = prefs.getStringList('counter') ?? [];
    final counterValues = counterStrings.map((str) => int.parse(str)).toList();
    counter.assignAll(counterValues);
    update();
  }
  Future clear() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
      prefs.remove('cartItems');
      itemsList.clear();
      counter.clear();
      itemCart.clear();
      numberOfItem.value = 0;
      update();
  }
}
