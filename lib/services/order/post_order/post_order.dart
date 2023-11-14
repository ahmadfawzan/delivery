import 'dart:convert';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/controllers/cart_controller/cart_controller.dart';
import 'package:delivery/controllers/categorie_controller/categorie_controller.dart';
import 'package:delivery/controllers/checkout_controller/checkout_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../controllers/shop_controller/shop_controller.dart';
import '../../../widgets/text_widgets.dart';

class RemoteServicesNewOrder {
  static Future postNewOrder(
      {required CheckOutController checkOutController,
      required CartController cartController,
      required CategorieController categorieController,
      required BuildContext context}) async {
    final ShopController shopController = Get.find();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var body =
      {
        "category_id": categorieController.id,
        "payment_type": checkOutController.selectedPaymentValue,
        "wallet_id": null,
        "order_type": "scheduled",
        "order_date": checkOutController.selectedDate,
        "order_time_from": checkOutController.selectedFromTime,
        "order_time_to": checkOutController.selectedToTime,
        "expedited_fees": categorieController.expeditedFees ?? 0,
        "order": 1,
        "delivery_fee": categorieController.deliveryFee,
        "total": checkOutController.calculateTotalOrder(),
        "address_id": checkOutController.popMenuValueCheckOut[0].id ??
            checkOutController.changeAddressList.first.id,
        "type": 1,
        "shop_id": shopController.id ?? 0,
        "count": cartController.itemsList.length,
        "night_order": true,
        "commesion": categorieController.commesion ?? 0,
        "carts": cartController.itemsList,
      };
    final response = await http.post(
      Uri.parse('https://news.wasiljo.com/public/api/v1/user/orders'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
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
          text: 'The order has been added successfully',
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
          text: '${data['message']??data['error']}',
        ),
      ).show();
    }
  }
}
