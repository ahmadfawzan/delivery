import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/user/post_user/post_login_user.dart';
import '../../../views/about_us.dart';
import '../../../widgets/text_widgets.dart';

Future localStorageSignUpUser(
    TextEditingController name,
    TextEditingController email,
    TextEditingController mobileNumber,
    TextEditingController password,
    String dropDownValue,
    String countryCode,
    {required BuildContext context}) async {
  SharedPreferences signUpUser = await SharedPreferences.getInstance();
  signUpUser.setString('name', name.text);
  signUpUser.setString('email', email.text);
  signUpUser.setString('mobileNumber', mobileNumber.text);
  signUpUser.setString('Password', password.text);
  signUpUser.setString('dropDownValue', dropDownValue);
  signUpUser.setString('countryCode', countryCode);
  String? getName = signUpUser.getString('name');
  String? getEmail = signUpUser.getString('email');
  String? getDropDownValue = signUpUser.getString('dropDownValue');
  String? getMobileNumber = signUpUser.getString('mobileNumber');
  String? getPassword = signUpUser.getString('Password');
  String? getCountryCode = signUpUser.getString('countryCode');

  if (
      getEmail!.isNotEmpty &&
      getName!.isNotEmpty &&
      getMobileNumber!.isNotEmpty &&
      getPassword.toString().isNotEmpty &&
      getDropDownValue!.isNotEmpty &&
      getCountryCode!.isNotEmpty) {
    Get.toNamed("/login");
    if (!context.mounted) return;
    AwesomeDialog(
      animType: AnimType.leftSlide,
      dialogType: DialogType.success,
      btnOkOnPress: () {},
      context: context,
      title: 'Success',
      body: const TextWidgets(
        text: 'You have been successfully registered on the site',
        textAlign: TextAlign.center,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ).show();
  } else {
    Get.toNamed("/signUp");
  }
}

Future localStorageLoginUser(TextEditingController mobileNumber,
    TextEditingController password, String countryCode,
    {required BuildContext context}) async {
  SharedPreferences signUpUser = await SharedPreferences.getInstance();
  signUpUser.setString('mobileNumber', mobileNumber.text);
  signUpUser.setString('Password1', password.text);
  signUpUser.setString('countryCode', countryCode);
  String? getMobileNumber = signUpUser.getString('mobileNumber');
  String? getPassword = signUpUser.getString('Password1');
  String? getCountryCode = signUpUser.getString('countryCode');

  if (getMobileNumber!.isNotEmpty &&
      getPassword.toString().isNotEmpty &&
      getCountryCode!.isNotEmpty) {
    if (!context.mounted) return;
    PostLogin(mobileNumber, countryCode, password, context: context);
  } else {
    if (!context.mounted) return;
    Get.toNamed("/login");
  }
}

Future localStorageCheck({required BuildContext context}) async {
  SharedPreferences sharedtoken = await SharedPreferences.getInstance();
  String? token = sharedtoken.getString('token');
  if (token == null || token.isEmpty) {
    if (!context.mounted) return;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AboutUs()));
  } else {
    Get.offAllNamed('/home');
  }
}
