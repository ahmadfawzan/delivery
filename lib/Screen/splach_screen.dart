import 'dart:async';
import 'package:delivery/Utils/Ui/imagewidgets.dart';
import 'package:flutter/material.dart';
import 'about_us.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds:4),()=>Navigator.push(context,  MaterialPageRoute(builder: (context) =>    const AboutUs()),));
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: ImageWidget(image:'assets/images/image1.jfif',width:180,height:150)),
    );
  }
}
