
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/Server/firebase_auth.dart';
import 'package:delivery/Utils/Ui/textformfieldwidgets.dart';
import 'package:delivery/Utils/Ui/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {

  const Profile({super.key, });

  @override
  State<Profile> createState() => _ProfileState();
}



class _ProfileState extends State<Profile> {
  var documentID;
  String? name;
  String? email;
  String? mobileNumber;
  String? carNumber;
  final TextEditingController nameController= TextEditingController();
  final TextEditingController emailController= TextEditingController();
  final TextEditingController mobileNumberController= TextEditingController();
  final TextEditingController carNumberController= TextEditingController();
  Future getData() async{
    SharedPreferences signUpUser = await SharedPreferences.getInstance();
    String? getMobileNumber = signUpUser.getString('mobileNumber');

    var collection = FirebaseFirestore.instance.collection('user');
    var querySnapshots = await collection.where('Mobile Number',isEqualTo: getMobileNumber).get();
    for (var snapshot in querySnapshots.docs) {
      documentID = snapshot.id;
    }
    await FirebaseFirestore.instance.collection('user').doc(documentID).get().then((DocumentSnapshot ds) {
      name = ds['Name'];
      email = ds['Email'];
      mobileNumber = ds['Mobile Number'];
      carNumber = ds['Car Number'];
    }
    );
  }


  @override
  void initState(){
    getData().whenComplete(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SingleChildScrollView(
        child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 150,
                child:  const Row(
                  children: [
                    SizedBox(width: 25,),
                    Icon(Icons.arrow_back,color:Colors.grey ,size: 25,),
                    SizedBox(width: 80,),
                    TextWidgets(text:"Account Info",fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey,),
                  ],
                ),
              ),
              SizedBox(height: 15),
               Container(
          color: Colors.white,
          width: double.infinity,
          height: 475,
          child: Padding(
          padding: const EdgeInsets.only(left: 40.0,right: 40.0),
          child: Column(

                    children: [
                      SizedBox(height: 40,),
                      TextFormFieldWidgets(
                        labelText: 'Name',
                          hintText: '$name',
                          controller: nameController,
                          borderRudiucCircularSize: 10,
                          alignLabelWithHint: true,
                          validator: (value){
                            if(value == null || value.isEmpty ) {
                              return 'Please enter your name';
                            }
                            return null;}
                      ),
                  SizedBox(height: 20,),
                      TextFormFieldWidgets(
                          labelText: 'Email',
                          hintText: '$email',
                          controller: emailController,
                          borderRudiucCircularSize: 10,
                          alignLabelWithHint: true,
                          validator: (value){
                            if(value == null || value.isEmpty ) {
                              return 'Please enter your Email';
                            }
                            return null;}
                      ),
                      SizedBox(height: 20,),
                      TextFormFieldWidgets(
                          labelText: 'Car Number',
                          hintText: '$carNumber',
                          controller: carNumberController,
                          borderRudiucCircularSize: 10,
                          alignLabelWithHint: true,
                          validator: (value){
                            if(value == null || value.isEmpty ) {
                              return 'Please enter your Car Number';
                            }
                            return null;}
                      ),
                      SizedBox(height: 20,),
                      TextFormFieldWidgets(
                          labelText: 'Mobile Number',
                          hintText: '$mobileNumber',
                          controller: mobileNumberController,
                          borderRudiucCircularSize: 10,
                          alignLabelWithHint: true,
                          validator: (value){
                            String validMobileNumber = r'(^[0-9]{9}$)';
                            RegExp regExp = RegExp(validMobileNumber);
                            if(value == null || value.isEmpty ) {
                              return 'Please enter your Mobile Number';
                            }
                            if (!regExp.hasMatch(value)) {
                              return 'Please enter 9 number only';
                            }
                            return null;}
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 150,
                        child: MaterialButton(
                            onPressed: (){
                              updateUser(name,email,mobileNumber,carNumber,nameController,emailController,mobileNumberController,carNumberController,documentID);
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
                                SizedBox(width:19,),
                                TextWidgets(text:"Save",fontSize: 13,fontWeight: FontWeight.bold),

                                SizedBox(width: 22,),
                                Icon(Icons.arrow_forward,color:Colors.white ,size: 15,),
                              ],
                            )
                        ),
                      ),
                ],
              )
             ),

      ),


         ]
          ),
      )

    );
  }
}
