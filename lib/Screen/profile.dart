import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/Utils/Ui/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../Utils/Ui/material_button_widgets.dart';
import '../Utils/Ui/text_form_field_widgets.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /*var documentID;*/
  String? name;
  String? email;
  String? mobileNumber;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  bool isloading = true;

  Future UpdateProfile() async {
    SharedPreferences sharedtoken = await SharedPreferences.getInstance();
    String? token = sharedtoken.getString('token');
    final response = await http.put(
      Uri.parse(
          'https://news.wasiljo.com/public/api/v1/user/update_profile?lang=ar'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "name":
            nameController.text.isEmpty ? name : nameController.text.toString(),
        "email": emailController.text.isEmpty
            ? email
            : emailController.text.toString(),
        "mobile": mobileNumberController.text.isEmpty
            ? mobileNumber
            : '962${mobileNumberController.text.toString()}',
      },
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      if (!mounted) return;
      AwesomeDialog(
        animType: AnimType.leftSlide,
        dialogType: DialogType.success,
        btnOkOnPress: () {},
        context: context,
        title: 'Success',
        body: const TextWidgets(
          text: 'Your account has been modified',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ).show();
    } else {
      if (mounted) {
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
  }

  Future getProfile() async {
    SharedPreferences sharedtoken = await SharedPreferences.getInstance();
    String? token = sharedtoken.getString('token');

    final response = await http.put(
      Uri.parse(
          'https://news.wasiljo.com/public/api/v1/user/update_profile?lang=ar'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final ProfilList = jsonRes['data']['user'];
      setState(() {
        name = ProfilList['name'];
        email = ProfilList['email'];
        mobileNumber = ProfilList['mobile'];
        isloading = false;
      });
    } else {
      throw Exception('Failed to load Profile');
    }
  }

  /*Future getData() async {
    SharedPreferences signUpUser = await SharedPreferences.getInstance();
    String? getMobileNumber = signUpUser.getString('mobileNumber');

    var collection = FirebaseFirestore.instance.collection('user');
    var querySnapshots = await collection
        .where('Mobile Number', isEqualTo: getMobileNumber)
        .get();
    for (var snapshot in querySnapshots.docs) {
      documentID = snapshot.id;
    }
    await FirebaseFirestore.instance
        .collection('user')
        .doc(documentID)
        .get()
        .then((DocumentSnapshot ds) {
      name = ds['Name'];
      email = ds['Email'];
      mobileNumber = ds['Mobile Number'];
      carNumber = ds['Car Number'];
    });
  }*/

  @override
  void initState() {
    /*getData().whenComplete(() => setState(() {}));*/
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          height: 150,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              isloading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
              const SizedBox(
                width: 60,
              ),
              isloading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const TextWidgets(
                        text: 'Account Info',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ))
                  : const TextWidgets(
                      text: "Account Info",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          color: Colors.white,
          width: double.infinity,
          height: 475,
          child: Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  isloading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 50,
                          ),
                        )
                      : TextFormFieldWidgets(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          labeltext: 'Name',
                          hintText: name ?? "",
                          controller: nameController,
                          alignLabelWithHint: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffBFBFBF)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          labelstyle: const TextStyle(color: Color(0xff9B9B9B)),
                          hintstyle: const TextStyle(color: Color(0xff9B9B9B)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          }),
                  const SizedBox(
                    height: 20,
                  ),
                  isloading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )
                      : TextFormFieldWidgets(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          labeltext: 'Email',
                          hintText: email ?? "",
                          controller: emailController,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffBFBFBF)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          labelstyle: const TextStyle(color: Color(0xff9B9B9B)),
                          hintstyle: const TextStyle(color: Color(0xff9B9B9B)),
                          alignLabelWithHint: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email';
                            }
                            return null;
                          }),
                  const SizedBox(
                    height: 20,
                  ),
                  /*TextFormFieldWidgets(
                      labeltext: 'Car Number',
                      hintText: '$carNumber',
                      controller: carNumberController,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Color(0xffBFBFBF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color(0xffBFBFBF),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color(0xffBFBFBF),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color(0xffBFBFBF),
                        ),
                      ),
                      labelstyle: const TextStyle(color: Color(0xff9B9B9B)),
                      hintstyle: const TextStyle(color: Color(0xff9B9B9B)),
                      alignLabelWithHint: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Car Number';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),*/
                  isloading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )
                      : TextFormFieldWidgets(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          labeltext: 'Mobile Number',
                          hintText: mobileNumber ?? "",
                          labelstyle: const TextStyle(color: Color(0xff9B9B9B)),
                          hintstyle: const TextStyle(color: Color(0xff9B9B9B)),
                          controller: mobileNumberController,
                          alignLabelWithHint: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Color(0xffBFBFBF)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xffBFBFBF),
                            ),
                          ),
                          validator: (value) {
                            String validMobileNumber = r'(^[0-9]{9}$)';
                            RegExp regExp = RegExp(validMobileNumber);
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Mobile Number';
                            }
                            if (!regExp.hasMatch(value)) {
                              return 'Please enter 9 number only';
                            }
                            return null;
                          }),
                  const SizedBox(
                    height: 20,
                  ),
                  isloading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 45,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 150,
                          child: MaterialButtonWidgets(
                              onPressed: () {
                                UpdateProfile();
                              },
                              height: 45,
                              minWidth: double.infinity,
                              textColor: Colors.white,
                              color: const Color(0xff14CB95),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 19,
                                  ),
                                  TextWidgets(
                                      text: "Save",
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ],
                              )),
                        ),
                ],
              )),
        ),
      ]),
    ));
  }
}
