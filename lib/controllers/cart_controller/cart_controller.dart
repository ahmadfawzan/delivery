import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartController extends GetxController{
  RxList itemCart = <Map<String, dynamic>>[].obs;
  var isLoading=true.obs;
  RxInt numberOfItem=0.obs;

  void addItemToCart() async {
    if(itemCart.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('cartItems', itemCart.map((item) => json.encode(item)).toList());
      List? savedItems = prefs.getStringList('cartItems');
      numberOfItem.value=savedItems!.length;
      update();
    }
  }

}