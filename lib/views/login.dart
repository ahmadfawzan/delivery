import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../utils/Helper/shared_preferences/shared_preferences.dart';
import '../widgets/country_code_picker.dart';
import '../widgets/image_widgets.dart';
import '../widgets/material_button_widgets.dart';
import '../widgets/text_form_field_widgets.dart';
import '../widgets/text_widgets.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  String countryCode = '962';
  bool passwordVisible = true;

  void onCountryChange(CountryCode CountryCode1) async {
    setState(() {
      countryCode = CountryCode1.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(children: [
           const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(
                image: 'assets/images/image1.jfif',
                height: 100,
                width: 140,
              ),
              TextWidgets(
                  text: "WELCOME BACK!",
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff15CB95),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: countryCodePicker(countryCode, onCountryChange),
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    SizedBox(
                      width: countryCode.length < 5 ? 245 : 237,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: TextFormFieldWidgets(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            hintText: 'Mobile Number',
                            controller: mobileNumber,
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
                            labelstyle:
                                const TextStyle(color: Color(0xff9B9B9B)),
                            hintstyle:
                                const TextStyle(color: Color(0xff9B9B9B)),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Colors.black,
                              size: 25,
                            ),
                            alignLabelWithHint: true,
                            validator: (value) {
                              /*r'^7[789](\d{7})$' jordan mobile number*/
                              String validMobileNumber = r'^7[789](\d{7})$';
                              RegExp regExp = RegExp(validMobileNumber);
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Mobile Number';
                              }
                              if (!regExp.hasMatch(value)) {
                                return 'Please enter jordan number number only';
                              }
                              return null;
                            }),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormFieldWidgets(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  hintText: 'Password',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password length at least 6 character';
                    }
                    return null;
                  },
                  controller: password,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black,
                    size: 25,
                  ),
                  alignLabelWithHint: true,
                  passwordVisible: passwordVisible,
                  suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      }),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      child: const TextWidgets(
                        text: 'Forget Password ?',
                      ),
                    )),
                MaterialButtonWidgets(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        localStorageLoginUser(
                            mobileNumber, password, countryCode,
                            context: context);
                      }
                    },
                    height: 50,
                    minWidth: double.infinity,
                    textColor: Colors.white,
                    color: const Color(0xff15CB95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 75,
                        ),
                        TextWidgets(
                            text: "LOG IN",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          width: 80,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  child: const TextWidgets(
                    text: "Don't have an account?",
                    textDecoration: TextDecoration.underline,
                  ),
                )),
              ],
            ),
          )
        ]),
      ))),
    );
  }
}
