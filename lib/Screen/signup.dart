import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:delivery/Utils/Helper/localstorage_singup_and_login.dart';
import 'package:delivery/Utils/Ui/country_code_picker.dart';
import 'package:delivery/Utils/Ui/image_widgets.dart';
import 'package:delivery/Utils/Ui/textformfield_widgets.dart';
import 'package:delivery/Screen/login.dart';
import 'package:delivery/Utils/Ui/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? image;
  final picker = ImagePicker();
  File? image1;
  bool passwordVisible = true;
  String? nameImage;
  String? nameImage1;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name= TextEditingController();
  final TextEditingController email= TextEditingController();
  final TextEditingController carNumber= TextEditingController();
  final TextEditingController mobileNumber= TextEditingController();
  final TextEditingController password= TextEditingController();
  String countryCode='962';

  void  onCountryChange(CountryCode CountryCode1) async{

    setState(() {
      countryCode =CountryCode1.toString();
    });}

  String dropDownValue = 'Gas Service';
  var items = [
    'Gas Service',
    'Water'
  ];
   Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        nameImage=pickedFile.name.toString();
      }
    });
  }

  Future getImageFromGallery1() async {
    final pickedFile1 = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile1 != null) {
        image1 = File(pickedFile1.path);
        nameImage1=pickedFile1.name.toString();
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        nameImage=pickedFile.name.toString();
      }
    });
  }
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 150,
        decoration:  const BoxDecoration(
            color: Colors.white,
            borderRadius:  BorderRadius.only(
                topLeft:  Radius.circular(10.0),
                topRight:  Radius.circular(10.0))),
        child: CupertinoActionSheet(

          actions: [
            Container(
              decoration:  const BoxDecoration(
                  color: Colors.white,
        ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    CupertinoActionSheetAction(
                      child: const Column(
                        children: [
                          Icon(Icons.photo,color:Color(0xff039371)  ,size: 60,),
                          TextWidgets(text:"Gallery",fontSize: 15),

                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        getImageFromGallery();
                      },
                    ),
                const SizedBox(width: 55,),
                    CupertinoActionSheetAction(
                      child: const Column(
                        children: [
                          Icon(Icons.camera_alt,color:Color(0xff039371)  ,size: 60,),
                          TextWidgets(text:"Camera",fontSize: 15),

                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        getImageFromCamera();
                      },
                    ),
              ],),
            )

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child:Container(
            padding: const EdgeInsets.only(top:35.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ImageWidget(image:'assets/images/image1.jfif',width:140,height:100),
                const TextWidgets(text:"SIGN UP",fontSize: 19,fontWeight: FontWeight.w700, color: Color(0xff495058)),
              Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                child: Column(
                children:[
                  const SizedBox(height: 10,),
                  TextFormFieldWidgets(
                    hintText: 'Name',
                    controller: name,
                    prefixIcon: const Icon(Icons.perm_identity_rounded,color:Colors.black  ,size: 25,),
                    alignLabelWithHint: true,
                  validator: (value){
                    if(value == null || value.isEmpty ) {
                      return 'Please enter your name';
                    }
                    return null;}
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration:  BoxDecoration(
                            color: const Color(0xff15CB95),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child:countryCodePicker(countryCode,onCountryChange),
                        ),
                      ),

                      const SizedBox(width: 8,),
                       SizedBox(
                        width:246,
                        height:80,
                         child:  Padding(
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
                               return null;
                             }
                           ),
                         ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldWidgets(
                      hintText: 'Email',
                      controller: email,
                      prefixIcon: const Icon(Icons.email_outlined,color:Colors.black  ,size: 25,),
                      alignLabelWithHint: true,
                      validator: (value){
                        if(value == null || value.isEmpty ) {
                          return 'Please enter your Email';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 5,),
                   image == null ? const TextWidgets(text: '',) : Image.file(image!),
                  const SizedBox(height: 7,),
                  TextFormField(

                              onTap: () => showOptions(),
                              readOnly: true,

                    validator: (value){
                      if(image == null){
                        return 'Please enter your image';
                      }
                      return null;
                    },
                              decoration:    InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(color: Colors.black,width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(color: Colors.black,width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(color: Colors.black,width: 2),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(color: Colors.black,width: 2),
                                ),
                                hintText:'Profile Picture',
                                labelText: nameImage == null ?  "" : nameImage!.toString(),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(color: Color(0xff1D1D1D),fontSize: 12,fontWeight: FontWeight.bold),
                                hintStyle: const TextStyle(color: Color(0xff1D1D1D),fontSize: 14,fontWeight: FontWeight.bold) ,
                                suffixIcon: const Icon(Icons.photo_library,color: Colors.black  ,size: 20,),
                              ),
                            ),


                  image1 == null ? const TextWidgets(text: "",) : Image.file(image1!),
                  const SizedBox(height: 7,),
                  TextFormField(
                    validator: (value){
                      if(image1 == null){
                        return 'Please enter your image';
                      }
                      return null;
                    },
                        readOnly: true,
                        decoration:    InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.black,width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.black,width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.black,width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.black,width: 2),
                          ),
                          hintText:nameImage1 == null ?  "License Picture" : nameImage1!.toString() ,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: const TextStyle(color: Color(0xff1D1D1D),fontSize: 14,fontWeight: FontWeight.bold) ,
                          suffixIcon:
                            IconButton(
                              onPressed:getImageFromGallery1,
                              iconSize: 20,
                              icon: const Icon(Icons.photo_library,color: Colors.black,),
                          ),
                        ),
                      ),
                  const SizedBox(height: 15,),
                  TextFormFieldWidgets(
                    validator: (value){
                      if(value ==null || value.isEmpty){
                        return 'Please enter your Car Number';
                      }
                      return null;
                    },
                    hintText: 'Car Number',
                    controller: carNumber,
                    prefixIcon: const Icon(Icons.numbers_outlined,color:Colors.black  ,size: 25,),
                    alignLabelWithHint: true,

                  ),

                  const SizedBox(height: 15,),
                  DropdownButtonFormField(
                    isExpanded: true,

                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB9B9B9)),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB9B9B9)),
                      ),


                    ),
                      value: dropDownValue,

                    icon: const Icon(Icons.keyboard_arrow_down),


                    items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                    ),

                  const SizedBox(height: 15,),
                  TextFormFieldWidgets(
                    hintText: 'Password',
                    controller: password,
                    prefixIcon:  const Icon(Icons.lock_outline_rounded,color:Colors.black  ,size: 25,),
                    alignLabelWithHint: true,
                    passwordVisible:passwordVisible,
                    suffixIcon: IconButton(icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off,color: Colors.black,),
                        onPressed: () {setState(() {passwordVisible = !passwordVisible;
                        });
                        }),
                    validator: (value){
                      if(value == null || value.isEmpty ) {

                        return 'Please enter your password';

                      }
                      if(value.length < 6){

                        return 'Password length at least 6 character';
                      }
                      return null;
                    },
                  ),


                  const SizedBox(height: 25,),
                  MaterialButton(
                      onPressed: (){
    if (_formKey.currentState!.validate()) {

                        localStorageSignUpUser(name,email,carNumber,nameImage!,nameImage1!,mobileNumber,password,dropDownValue,countryCode,context:context);
                        };},
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
                          TextWidgets(text:"CREATE",fontSize: 17,fontWeight: FontWeight.bold),

                          SizedBox(width: 80,),
                          Icon(Icons.arrow_forward,color:Colors.white ,size: 20,),
                        ],
                      )
                  ),
                  const SizedBox(height: 5,),
                  Center(
                      child: TextButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),);
                      },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,

                        ),
                        child: const TextWidgets(text:"Already have an account?",
                          textDecoration: TextDecoration.underline,
                        ),)




                  ),

                ]
                )
              )
              ],
            )
          )
        )
      ),
    );
  }
}
