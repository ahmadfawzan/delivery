/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../models/shop_model/shop_model.dart';
import '../widgets/network_image.dart';
import '../widgets/text_form_field_widgets.dart';
import '../widgets/text_widgets.dart';
import 'add_new_address.dart';
import 'item_shop.dart';

class Shops extends StatefulWidget {
  final int? id;
  final List? addresses;
  final String? popMenuValue;

  const Shops(
      {Key? key,
        required this.id,
        required this.addresses,
        required this.popMenuValue})
      : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  String? popMenuValue;
  var lat;
  var long;
  List? shopsItemList;
  String searchText = '';
  bool isloading = true;

  Future fetchLatAndLong() async {
    if (widget.addresses!.isEmpty) {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        dialogType: DialogType.error,
        btnOkOnPress: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddNewAddress()));
        },
        title: "NO Found Location",
        body: const TextWidgets(
          text: "Please Click Ok To Add New Loction",
          fontSize: 15,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ).show();
    } else {
      List? address = widget.addresses
          ?.where((element) =>
      (element.type == 1
          ? 'Home (${element.street})'
          : element.type == 2
          ? 'Work (${element.street})'
          : element.type == 3
          ? 'Other (${element.street})'
          : '') ==
          (popMenuValue ??
              widget.popMenuValue ??
              (widget.addresses?[0].type == 1
                  ? "Home (${widget.addresses?[0].street.toString()})"
                  : widget.addresses?[0].type == 2
                  ? "Work (${widget.addresses?[0].street.toString()})"
                  : widget.addresses?[0].type == 3
                  ? "Other (${widget.addresses?[0].street.toString()})"
                  : '')))
          .toList();
      address
          ?.map((e) => setState(() {
        lat = e.latitude;
        long = e.longitude;
      }))
          .toList();
      fetchShops();
    }
  }

  Future fetchShops() async {
    final queryParameters = {
      'latitude': lat,
      'longitude': long,
    };

    final uri = Uri.https(
        'news.wasiljo.com',
        '/public/api/v1/user/get-delivery-or-shop-by-location/1/location',
        queryParameters);
    final response = await http.get(uri);
    final jsonRes = json.decode(response.body);
    if (response.statusCode == 200) {
      final shopsList = jsonRes['data']['shops'] as List<dynamic>;
      setState(() {
        isloading = false;
        final shops =
        shopsList.map((json) => ShopsList.fromJson(json)).toList();
        shopsItemList = shops
            .where((element) =>
        element.categoryId == widget.id && searchText.isEmpty ||
            element.shopNameEn!.contains(searchText.toString()) &&
                searchText.isNotEmpty)
            .toList();
      });
    } else {
      if (!mounted) return;
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        dialogType: DialogType.error,
        btnOkOnPress: () {},
        title: "Error Api Shop",
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: TextWidgets(
            text: '${jsonRes['error']}',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
      ).show();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchLatAndLong());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 40, right: 18, left: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                          onPressed: () => {Navigator.of(context).pop()},
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 25,
                          ));
                    }),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_bag,
                        color: Color(0xff4E5156),
                        size: 25,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 228.0),
                  child: TextWidgets(
                    text: "Delvering To",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 151.0),
                  child: SizedBox(
                      width: 150,
                      height: 30,
                      child: PopupMenuButton<String>(
                          color: const Color(0xffEBFAF5),
                          onSelected: (value) {
                            setState(() {
                              popMenuValue = value;
                              fetchLatAndLong();
                            });
                          },
                          child: Row(
                            children: [
                              widget.addresses!.isEmpty
                                  ? const TextWidgets(text: '')
                                  : Expanded(
                                  child: TextWidgets(
                                    text: popMenuValue ??
                                        widget.popMenuValue ??
                                        (widget.addresses?[0].type == 1
                                            ? "Home (${widget.addresses?[0]!.street.toString()})"
                                            : widget.addresses?[0]!.type == 2
                                            ? "Work (${widget.addresses?[0]!.street.toString()})"
                                            : widget.addresses?[0].type ==
                                            3
                                            ? "Other (${widget.addresses?[0]!.street.toString()})"
                                            : ''),
                                    fontWeight: FontWeight.bold,
                                    textOverFlow: TextOverflow.ellipsis,
                                    fontSize: 15,
                                  )),
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.green,
                                size: 25,
                              ),
                            ],
                          ),
                          itemBuilder: (context) => [
                            ...?widget.addresses?.map((item) {
                              return PopupMenuItem<String>(
                                value: item.type == 1
                                    ? "Home (${item.street.toString()})"
                                    : item.type == 2
                                    ? "Work (${item.street.toString()})"
                                    : "Other (${item.street.toString()})",
                                child: Container(
                                  width: 190,
                                  padding:
                                  const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextWidgets(
                                        text: item.type == 1
                                            ? item.street.toString()
                                            : item.type == 2
                                            ? item.street.toString()
                                            : item.street.toString(),
                                        textOverFlow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      TextWidgets(
                                        text: item.type == 1
                                            ? '${item.city.toString()} - ${item.apartmentNum.toString()}'
                                            : item.type == 2
                                            ? '${item.city.toString()} - ${item.apartmentNum.toString()}'
                                            : '${item.city.toString()} - ${item.apartmentNum.toString()}',
                                        textOverFlow: TextOverflow.ellipsis,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Theme(
                                        data: ThemeData(
                                          dividerColor: Colors.black,
                                        ),
                                        child: const PopupMenuDivider(
                                          height: 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            PopupMenuItem(
                              child: const TextWidgets(
                                  text: '+Add new address'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const AddNewAddress(),
                                  ),
                                );
                              },
                            )
                          ])),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 195.0),
                  child: TextWidgets(
                    text: 'Replace Bottles',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff676666),
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                width: 176,
                height: 50,
                color: Colors.white,
                child: TextFormFieldWidgets(
                  hintText: 'Fiters',
                  onTap: () {},
                  readOnly: true,
                  prefixIcon: const Icon(
                    Icons.filter,
                    color: Color(0xff676666),
                    size: 25,
                  ),
                  inputBorder: InputBorder.none,
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                width: 181,
                height: 50,
                color: Colors.white,
                child: TextFormFieldWidgets(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                      fetchLatAndLong();
                    });
                  },
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: Color(0xff676666),
                    size: 30,
                  ),
                  inputBorder: InputBorder.none,
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 7),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: shopsItemList?.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          height: 120,
                          child: isloading
                              ? Shimmer.fromColors(
                              baseColor: Colors.grey[350]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.white,
                                height: 120,
                                width: double.infinity,
                              ))
                              : InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ItemShop(
                                    id: shopsItemList?[index].id,
                                    addresses: widget.addresses,
                                    popMenuValue: popMenuValue,
                                    popMenuValue1: widget.popMenuValue,
                                  )));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 25,
                                ),
                                shopsItemList?[index].open == 1
                                    ? ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  child: ImageNetworkWidget(
                                    image:
                                    'https://news.wasiljo.com/${shopsItemList?[index].license.toString()}',
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.fitHeight,
                                    errorbuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                        'assets/images/image2.png',
                                        fit: BoxFit.fitHeight,
                                        height: 90,
                                        width: 90,
                                      );
                                    },
                                  ),
                                )
                                    : SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: ImageNetworkWidget(
                                          image:
                                          'https://news.wasiljo.com/${shopsItemList?[index].license.toString()}',
                                          height: 90,
                                          width: 90,
                                          fit: BoxFit.fitHeight,
                                          errorbuilder: (BuildContext
                                          context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Image.asset(
                                              'assets/images/image2.png',
                                              fit: BoxFit.fitHeight,
                                              height: 90,
                                              width: 90,
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
                                          text: shopsItemList?[index]
                                              .open ==
                                              0
                                              ? "Closed"
                                              : "Busy",
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextWidgets(
                                      text:
                                      '${shopsItemList?[index].shopNameEn.toString()}',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff000000),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    TextWidgets(
                                      text:
                                      '${shopsItemList?[index].address.toString()}',
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Color(0xff15CB95),
                                          size: 19,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        TextWidgets(
                                          text:
                                          '${shopsItemList?[index].rating.toString()}',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        TextWidgets(
                                          text:
                                          '(${shopsItemList?[index].totalRating.toString()}+ Ratings)',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}*/
