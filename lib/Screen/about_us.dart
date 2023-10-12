import 'package:delivery/Utils/Ui/image_widgets.dart';
import 'package:delivery/Utils/Ui/text_widgets.dart';
import 'package:flutter/material.dart';
import '../Utils/Helper/about_list.dart';
import '../Utils/Ui/material_button_widgets.dart';
import 'choose_login_or_sinup.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  PageController _controller = PageController();
  int countIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (int index) {
              setState(() {
                countIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ImageWidget(
                          image: pages[index].image,
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const TextWidgets(
                                text: 'Skip',
                                fontSize: 17,
                                color: Colors.white,
                                textDecoration: TextDecoration.none,
                              ),
                              IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                  color: Colors.white,
                                  iconSize: 17,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const AboutUs(),
                                    ));
                                  }),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 300),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    pages.length,
                                    (index) => Container(
                                          height: countIndex == index ? 12 : 8,
                                          width: countIndex == index ? 12 : 8,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                        )))),
                        Padding(
                          padding: const EdgeInsets.only(top: 320.0),
                          child: Container(
                            width: double.infinity,
                            height: 320,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0)),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextWidgets(
                                    text: pages[index].title,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  TextWidgets(
                                    text: pages[index].discription,
                                    fontSize: 15,
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  MaterialButtonWidgets(
                                      onPressed: () {
                                        /* 0,1,2             3-1=2 */
                                        if (countIndex == pages.length - 1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ChooseLoginOrSingup()));
                                        } else {
                                          _controller.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 10),
                                              curve: Curves.bounceIn);
                                        }
                                      },
                                      height: 60,
                                      minWidth: 220,
                                      textColor: Colors.white,
                                      color: const Color(0xff15CB95),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: TextWidgets(
                                          text: countIndex == pages.length - 1
                                              ? 'Get Started'
                                              : 'Next',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
