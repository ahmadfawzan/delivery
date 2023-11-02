import 'package:delivery/view/signup.dart';
import 'package:flutter/material.dart';
import '../widget/image_widgets.dart';
import '../widget/material_button_widgets.dart';
import '../widget/text_widgets.dart';
import 'login.dart';

class ChooseLoginOrSingup extends StatefulWidget {
  const ChooseLoginOrSingup({super.key});

  @override
  State<ChooseLoginOrSingup> createState() => _ChooseLoginOrSingupState();
}

class _ChooseLoginOrSingupState extends State<ChooseLoginOrSingup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff15CB95),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, top: 90),
        child: Column(
          children: [
            const ImageWidget(
                image: 'assets/images/Logo.png', width: 180, height: 150),
            Container(
              width: 283,
              child: MaterialButtonWidgets(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  height: 70,
                  minWidth: 150,
                  textColor: const Color(0xff15CB95),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidgets(
                          text: "Sign In",
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xff15CB95),
                        size: 18,
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 283,
              child: MaterialButtonWidgets(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  height: 70,
                  minWidth: 150,
                  textColor: Colors.white,
                  color: const Color(0xff15CB95),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1.0, color: Colors.white)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidgets(
                          text: "Sign Up",
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
