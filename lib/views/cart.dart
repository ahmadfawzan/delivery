import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/cart_controller/cart_controller.dart';
import '../widgets/material_button_widgets.dart';
import '../widgets/network_image.dart';
import '../widgets/text_widgets.dart';

class Cart extends StatefulWidget {
  const Cart({
    super.key,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartController cartController = Get.find();

  @override
  void initState() {
    cartController.retrieveCounterValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        cartController.clear();
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: Container(
          padding: const EdgeInsets.only(top: 20.0),
          color: Colors.white,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder(
                    init: CartController(),
                    builder: (cartController) => IconButton(
                        onPressed: () async {
                          cartController.clear();
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 25,
                        ))),
                cartController.itemsList.isEmpty
                    ? const Center(
                        child: TextWidgets(
                          text: "There are no products in the cart",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : GetBuilder(
                        init: CartController(),
                        builder: (cartController) => Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(left: 5),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: cartController.itemsList.length,
                              itemBuilder: (context, index) {
                                cartController.itemsList[index]?['total'] =
                                    cartController.calculateOneItems(index) != 0
                                        ? cartController
                                            .calculateOneItems(index)
                                            .toDouble()
                                        : cartController
                                            .itemsList[index]!['price']
                                            .toString();
                                return SingleChildScrollView(
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    height: 120,
                                    child: cartController.isLoading.value
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[350]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              color: Colors.white,
                                              height: 120,
                                              width: double.infinity,
                                            ))
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: ImageNetworkWidget(
                                                  image:
                                                      'https://news.wasiljo.com/${cartController.itemsList[index]?["imageUrl"]}',
                                                  height: 110,
                                                  width: 110,
                                                  fit: BoxFit.fitHeight,
                                                  errorbuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/image2.png',
                                                      height: 110,
                                                      width: 110,
                                                      fit: BoxFit.fitHeight,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 120,
                                                      child: TextWidgets(
                                                        text:
                                                            '${cartController.itemsList[index]?['title'][0]['en']}',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textOverFlow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 120,
                                                      child: TextWidgets(
                                                        text:
                                                            '${cartController.itemsList[index]?['description'][0]['en']}',
                                                        textOverFlow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        fontSize: 11,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 70,
                                                      child: TextWidgets(
                                                        text:
                                                            '${cartController.calculateOneItems(index) != 0 ? cartController.calculateOneItems(index).toDouble() : cartController.itemsList[index]!['price'].toString()}JD',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xff000000),
                                                        textOverFlow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Center(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10,
                                                              bottom: 15),
                                                      child: Container(
                                                        height: 40,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset: const Offset(
                                                                  0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: GetBuilder(
                                                          init:
                                                              CartController(),
                                                          builder:
                                                              (cartController) =>
                                                                  Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: 30,
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          cartController
                                                                              .increment(index);
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .add,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Color(0xff15CA95),
                                                                        )),
                                                              ),
                                                              SizedBox(
                                                                width: 40,
                                                                child: Center(
                                                                  child: cartController
                                                                          .counter
                                                                          .isEmpty
                                                                      ? const TextWidgets(
                                                                          text:
                                                                              "0",
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          textOverFlow:
                                                                              TextOverflow.ellipsis,
                                                                          fontSize:
                                                                              13,
                                                                        )
                                                                      : TextWidgets(
                                                                          text:
                                                                              "${cartController.counter[index]}",
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          textOverFlow:
                                                                              TextOverflow.ellipsis,
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 30,
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          cartController
                                                                              .decrement(index);
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .remove,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Color(0xff15CA95),
                                                                        )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )))
                                            ],
                                          ),
                                  ),
                                );
                              }),
                        ),
                      ),
                MaterialButtonWidgets(
                    onPressed: () async {
                      if (cartController.counter.isNotEmpty &&
                          cartController.counter
                              .any((element) => element > 0)) {
                        Get.toNamed("/checkout");
                      } else {
                        if (!mounted) return;
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          dialogType: DialogType.error,
                          btnOkOnPress: () async {},
                          btnCancelOnPress: () {},
                          title: "number of product",
                          body: const TextWidgets(
                            text:
                                "Please specify that the number of product items must not be zero",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                        ).show();
                      }
                    },
                    height: 50,
                    minWidth: double.infinity,
                    textColor: Colors.white,
                    color: const Color(0xff14CB95),
                    child: GetX(
                      init: CartController(),
                      builder: (cartController) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: 70,
                            child: TextWidgets(
                              text: "${cartController.calculateTotal()}",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          const TextWidgets(
                              text: "Complete Oreder",
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          const SizedBox(
                            width: 7,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    )),
              ]),
        ),
      ),
    );
  }
}
