import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:delivery/Utils/Ui/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Server/firebase_auth_ Just_to_learn.dart';
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
  var documentID;
  String? name;
  String? email;
  String? mobileNumber;
  String? carNumber;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController carNumberController = TextEditingController();

  Future getData() async {
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
  }

  @override
  void initState() {
    getData().whenComplete(() => setState(() {}));

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
                width: 25,
              ),
              IconButton(
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
                width: 80,
              ),
              const TextWidgets(
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
                  TextFormFieldWidgets(
                      labeltext: 'Name',
                      hintText: '$name',
                      controller: nameController,
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xffBFBFBF)),
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
                  TextFormFieldWidgets(
                      labeltext: 'Email',
                      hintText: '$email',
                      controller: emailController,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xffBFBFBF)),
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
                  TextFormFieldWidgets(
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
                  ),
                  TextFormFieldWidgets(
                      labeltext: 'Mobile Number',
                      hintText: '$mobileNumber',
                      labelstyle: const TextStyle(color: Color(0xff9B9B9B)),
                      hintstyle: const TextStyle(color: Color(0xff9B9B9B)),
                      controller: mobileNumberController,
                      alignLabelWithHint: true,
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
                  Container(
                    width: 150,
                    child: MaterialButtonWidgets(
                        onPressed: () {
                          updateUser(
                              name,
                              email,
                              mobileNumber,
                              carNumber,
                              nameController,
                              emailController,
                              mobileNumberController,
                              carNumberController,
                              documentID);
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
