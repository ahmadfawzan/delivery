import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../Utils/Helper/list_data_shops_api.dart';
import '../Utils/Ui/text_form_field_widgets.dart';
import '../Utils/Ui/text_widgets.dart';
import 'add_new_address.dart';

class Shops extends StatefulWidget {
  final int id;
  final List? addresses;

  const Shops({Key? key, required this.id, required this.addresses})
      : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  String? popMenuValue;
  var lat;
  var long;

  List? shopsItemList;

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
        body: const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: TextWidgets(
            text: "Please Click Ok To Add New Loction",
            fontSize: 15,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
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
    final response = await http.get(
      Uri.parse(
          'https://news.wasiljo.com/public/api/v1/user/get-delivery-or-shop-by-location/1/location?latitude=$lat&longitude=$long'),
    );
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final shopsList = jsonRes['data']['shops'] as List<dynamic>;

      setState(() {
        final shops =
            shopsList.map((json) => ShopsList.fromJson(json)).toList();
        shopsItemList =
            shops.where((element) => element.category_id == widget.id).toList();
      });
    } else {
      throw Exception('Failed to load Addresses');
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
                                ...?widget.addresses
                                    ?.map((item) => PopupMenuItem<String>(
                                          value: item.type == 1
                                              ? "Home (${item.street.toString()})"
                                              : item.type == 2
                                                  ? "Work (${item.street.toString()})"
                                                  : "Other (${item.street.toString()})",
                                          child: TextWidgets(
                                            text: item.type == 1
                                                ? "Home (${item.street.toString()})"
                                                : item.type == 2
                                                    ? "Work (${item.street.toString()})"
                                                    : "Other (${item.street.toString()})",
                                            textOverFlow: TextOverflow.ellipsis,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
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
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                width: 175,
                height: 60,
                color: Colors.white,
                child: TextFormFieldWidgets(
                  hintText: 'Fiters',
                  onTap: () {},
                  readOnly: true,
                  prefixIcon: const Icon(
                    Icons.filter,
                    color: Color(0xff676666),
                  ),
                  inputBorder: InputBorder.none,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: 180,
                height: 60,
                color: Colors.white,
                child: TextFormFieldWidgets(
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: Color(0xff676666),
                  ),
                  inputBorder: InputBorder.none,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,

                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: shopsItemList?.length,
                      itemBuilder: (context, index) {
                        return Text(
                            '${shopsItemList?[index].shop_name_en.toString()}');
                      }),
                ),
              ))
        ],
      ),
    );
  }
}
