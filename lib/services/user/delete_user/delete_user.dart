import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/address_controller/address_controller.dart';
import '../../../controllers/shop_controller/shop_controller.dart';
import '../../../views/signup.dart';
import '../../../widgets/text_widgets.dart';
Future DeleteUser({required BuildContext context}) async {
  final AddressController addressController = Get.find();
  final ShopController shopController = Get.put<ShopController>(ShopController());
  SharedPreferences sharedtoken = await SharedPreferences.getInstance();
  String? token = sharedtoken.getString('token');
  final response = await http.post(
    Uri.parse('https://news.wasiljo.com/public/api/v1/user/delete'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  var data = json.decode(response.body);
  if (response.statusCode == 200) {
    if (!context.mounted) return;
    AwesomeDialog(
      animType: AnimType.leftSlide,
      dialogType: DialogType.success,
      btnOkOnPress: () async {
        addressController.addressList.clear();
        shopController.shopList.clear();
        await sharedtoken.clear();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignUp()));
      },
      context: context,
      title: 'Success',
      body: TextWidgets(
        text: '${data['message']} Click OK to go to the page SignUp',
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
        text: '${data['error']}',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    ).show();
  }
}
