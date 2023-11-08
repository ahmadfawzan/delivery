import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../controllers/address_controller/address_controller.dart';
import '../../../widgets/text_widgets.dart';

class RemoteServicesAddress {
  static Future fetchAddress({required BuildContext context,int? id, required bool mounted}) async {
    SharedPreferences sharedtoken = await SharedPreferences.getInstance();
    String? token = sharedtoken.getString('token');
    final AddressController addressController = Get.find();
    final response = await http.delete(
      Uri.parse('https://news.wasiljo.com/public/api/v1/user/addresses/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      addressController.popMenuValue = null;
      addressController.fetchAddress();
    } else {
      if (!mounted) return;
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        dialogType: DialogType.error,
        btnOkOnPress: () {

        },
        btnCancelOnPress: () {},
        title: "Error Delete",
        body:  TextWidgets(
          text: "${data['error']}",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ).show();
    }
  }
}
