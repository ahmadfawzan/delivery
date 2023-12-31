import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../controllers/address_controller/address_controller.dart';
import '../../../widgets/text_widgets.dart';

Future PutAddresses({
  required BuildContext context,
  addressesType,
  lat,
  long,
  name,
  street,
  buildingNumber,
  city,
  apartmentNum,
}) async {
  final AddressController addressController = Get.find();
  SharedPreferences sharedtoken = await SharedPreferences.getInstance();
  String? token = sharedtoken.getString('token');
  final response = await http.put(
    Uri.parse(
        'https://news.wasiljo.com/public/api/v1/user/addresses/${addressesType[0].id}'),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: {
      "longitude": "${long ?? addressesType[0].longitude}",
      "latitude": "${lat ?? addressesType[0].latitude}",
      "name": name ?? addressesType[0].name,
      "street": street ?? addressesType[0].street,
      "building_number": buildingNumber.text ?? addressesType[0].buildingNumber,
      "city": city ?? addressesType[0].city,
      "apartment_num": apartmentNum.text ?? addressesType[0].apartmentNum,
    },
  );

  var data = json.decode(response.body);
  if (response.statusCode == 200) {
    if (addressController.popMenuValue != null && addressController.popMenuValue!.isNotEmpty) {
      addressController.changePopMenuValueWhenPutAddress(data);
    }
    if (!context.mounted) return;
    AwesomeDialog(
      animType: AnimType.leftSlide,
      dialogType: DialogType.success,
      btnOkOnPress: () {},
      context: context,
      title: 'Success',
      body: TextWidgets(
        text: addressesType[0].type == 1
            ? "Your Home Address Home has been modified"
            : addressesType[0].type == 2
                ? "Your Work Address  has been modified"
                : '',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    ).show();
  } else {
    if (!context.mounted) return;
    AwesomeDialog(
      animType: AnimType.leftSlide,
      dialogType: DialogType.success,
      btnOkOnPress: () {},
      title: 'Error',
      body: TextWidgets(
        text: '${data['error']}',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
      context: context,
    ).show();
  }
}
