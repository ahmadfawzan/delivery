
import 'package:country_code_picker/country_code_picker.dart';
import 'package:delivery/Utils/Helper/localstorage_singup_and_login.dart';
import 'package:delivery/Utils/Ui/country_code_picker.dart';
import 'package:delivery/Utils/Ui/imagewidgets.dart';
import 'package:delivery/Utils/Ui/textformfieldwidgets.dart';
import 'package:delivery/Utils/Ui/textwidgets.dart';
import 'package:flutter/material.dart';

import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileNumber= TextEditingController();
  final TextEditingController password= TextEditingController();
  String countryCode='962';




  @override
  bool passwordVisible = true;
  void  onCountryChange(CountryCode CountryCode1) async{
    setState(() {
      countryCode =CountryCode1.toString();
    });}
  @override

  Widget build(BuildContext context) {
    return   Form(
      key: _formKey,
      child: Scaffold(
         body: SingleChildScrollView(
        child:
        Container(
          padding: const EdgeInsets.only(top:100.0),
          child:   Column(
                children:[
                    const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(image:'assets/images/image1.jfif' ,height: 100,width: 140,),
                      TextWidgets(text:"WELCOME BACK!",fontSize: 17,fontWeight: FontWeight.bold),

                    ],
                  ),
                 const SizedBox(height: 15,),
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
                            decoration:  BoxDecoration(
                              color: const Color(0xff15CB95),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child:countryCodePicker(countryCode,onCountryChange),
                          ),
                        ),
                           const SizedBox(width: 8,),
                            SizedBox(
                             width:235,
                             height: 80,
                              child: Padding(
                                padding: const EdgeInsets.only(top :9.0),
                                child: TextFormFieldWidgets(
                                  hintText: 'Mobile Number',
                                  controller: mobileNumber,
                                  prefixIcon: const Icon(Icons.phone,color:Colors.black  ,size: 25,),
                                  alignLabelWithHint: true,
                                    validator: (value){
                                      /*r'^7[789](\d{7})$' jordan mobile number*/
                                      String validMobileNumber = r'(^[0-9]{9}$)';
                                      RegExp regExp = RegExp(validMobileNumber);
                                      if(value == null || value.isEmpty ) {
                                        return 'Please enter your Mobile Number';
                                      }
                                      if (!regExp.hasMatch(value)) {
                                        return 'Please enter 9 number only';
                                      }
                                    }
                                ),
                              ),
                           )
                      ],
                       ),
                       const SizedBox(height: 20,),
                       TextFormFieldWidgets(
                         hintText: 'Password',
                         validator: (value){
                           if(value == null || value.isEmpty ) {

                              return 'Please enter your password';

                            }
                            if(value.length < 6){

                              return 'Password length at least 6 character';
                            }
                       },
                         controller: password,
                         prefixIcon:  const Icon(Icons.lock_outline_rounded,color:Colors.black  ,size: 25,),
                         alignLabelWithHint: true,
                         passwordVisible:passwordVisible,
                         suffixIcon: IconButton(icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off,color: Colors.black,),
                             onPressed: () {setState(() {passwordVisible = !passwordVisible;
                             });
                             }),
                       ),
                       Align(
                           alignment: Alignment.topRight,
                           child: TextButton(onPressed: (){
                           },
                             style: TextButton.styleFrom(
                               foregroundColor: Colors.black,

                             ),
                             child: const TextWidgets(text: 'Forget Password ?',),)

                       ),
                       MaterialButton(
                           onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              localStorageLoginUser(mobileNumber,password,countryCode,context:context);}
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
                               SizedBox(width: 75,),
                               TextWidgets(text:"LOG IN",fontSize: 17,fontWeight: FontWeight.bold),
                               SizedBox(width: 80,),
                               Icon(Icons.arrow_forward,color:Colors.white ,size: 25,),
                             ],
                           )
                       ),
                       const SizedBox(height: 15,),
                        Center(
                         child: TextButton(onPressed: (){
                           Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => const SignUp(),

                           ),);
                         },
                           style: TextButton.styleFrom(
                             foregroundColor: Colors.grey,

                           ),
                           child: const TextWidgets(text:"Don't have an account?",  textDecoration: TextDecoration.underline,),
                           )




                       ),
                     ],
                   ),
                 )
                ]

          ),
        )

      )
      ),
    );
  }

}



