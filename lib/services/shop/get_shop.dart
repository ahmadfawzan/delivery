import 'package:delivery/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/address_controller/address_controller.dart';
import '../../models/shop_model/shop_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RemoteServicesShop {
  static Future<List<Shop>> fetchShop() async {

    final AddressController addressController = Get.find();
    if (addressController.addressList.isNotEmpty) {
      String? lat;
      String? long;
      List? address = addressController.addressList
          .where((element) =>
      (element.type == 1
          ? 'Home (${element.street})'
          : element.type == 2
          ? 'Work (${element.street})'
          : element.type == 3
          ? 'Other (${element.street})'
          : '') ==
          (addressController.popMenuValue ??
              (addressController.addressList[0].type == 1
                  ? "Home (${addressController.addressList[0].street.toString()})"
                  : addressController.addressList[0].type == 2
                  ? "Work (${addressController.addressList[0].street.toString()})"
                  : addressController.addressList[0].type == 3
                  ? "Other (${addressController.addressList[0].street.toString()})"
                  : '')))
          .toList();
      address.map((e) {
        lat = e.latitude;
        long = e.longitude;
      }).toList();

      final queryParameters = {
        'latitude': lat,
        'longitude': long,
      };
      final uri = Uri.https(
          'news.wasiljo.com',
          '/public/api/v1/user/get-delivery-or-shop-by-location/1/location',
          queryParameters);
      final response = await http.get(uri);
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return shopFromJson(data['data']['shops']);
      } else {
        throw Exception(data['error']);
      }
  }else{
      throw Exception(Get.defaultDialog(
        title: 'NO Found Location',
        content: const TextWidgets(
          text: 'Please Click Ok To Add New Location',
          fontSize: 15,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed("/addNewAddress");
              Get.back();
            },
            child: const TextWidgets(
              text: 'ok',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ));

    }
}}
