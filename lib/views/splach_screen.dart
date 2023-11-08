import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/Helper/shared_preferences/shared_preferences.dart';
import '../widgets/image_widgets.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4), () => localStorageCheck(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ImageWidget(
              image: 'assets/images/image1.jfif', width: 180, height: 150)),
    );
  }
}
