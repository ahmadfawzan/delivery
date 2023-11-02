import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/network_image.dart';
import '../widgets/text_widgets.dart';
import 'add_new_address.dart';

class Cart extends StatefulWidget {


  const Cart(
      {super.key,});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String? popMenuValue;
  List? itemShopsList;
  String searchText = '';
  bool isloading = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Container(
        padding: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              )),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(left: 5),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: itemShopsList?.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      height: 120,
                      child: isloading
                          ? Shimmer.fromColors(
                          baseColor: Colors.grey[350]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            color: Colors.white,
                            height: 120,
                            width: double.infinity,
                          ))
                          : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          itemShopsList?[index].quantity != 0
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ImageNetworkWidget(
                              image:
                              'https://news.wasiljo.com/${itemShopsList?[index].image_url.toString()}',
                              height: 110,
                              width: 110,
                              fit: BoxFit.fitWidth,
                              errorbuilder: (BuildContext context,
                                  Object exception,
                                  StackTrace? stackTrace) {
                                return Image.asset(
                                  'assets/images/image2.png',
                                  height: 110,
                                  width: 110,
                                  fit: BoxFit.fitWidth,
                                );
                              },
                            ),
                          )
                              : SizedBox(
                            width: 110,
                            height: 110,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  child: ImageNetworkWidget(
                                    image:
                                    'https://news.wasiljo.com/${itemShopsList?[index].image_url.toString()}',
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit.fitWidth,
                                    errorbuilder: (BuildContext
                                    context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                        'assets/images/image2.png',
                                        height: 110,
                                        width: 110,
                                        fit: BoxFit.fitWidth,
                                      );
                                    },
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  child: const Opacity(
                                    opacity: 0.5,
                                    child: ModalBarrier(
                                        dismissible: false,
                                        color: Colors.black),
                                  ),
                                ),
                                Center(
                                  child: TextWidgets(
                                    text: itemShopsList?[index]
                                        .quantity ==
                                        0
                                        ? "Not Available"
                                        : "",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top :15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextWidgets(
                                  text:
                                  '${itemShopsList?[index].title.toString()}',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff000000),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextWidgets(
                                  text:
                                  '${itemShopsList?[index].description.toString()}',
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextWidgets(
                                  text:
                                  '${itemShopsList?[index].price.toString()}JD',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff000000),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
