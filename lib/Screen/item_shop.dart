import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../Utils/Helper/list_data_item_shops_api.dart';
import '../Utils/Ui/network_image.dart';
import '../Utils/Ui/text_form_field_widgets.dart';
import '../Utils/Ui/text_widgets.dart';
import 'add_new_address.dart';

class ItemShop extends StatefulWidget {
  final int id;
  final List? addresses;
  final String? popMenuValue;
  final String? popMenuValue1;

  const ItemShop({super.key,
    required this.id,
    required this.addresses,
    required this.popMenuValue,
    required this.popMenuValue1});

  @override
  State<ItemShop> createState() => _ItemShopState();
}

class _ItemShopState extends State<ItemShop> {
  String? popMenuValue;
  List? itemShopsList;
  String searchText = '';
  bool isloading = true;

  Future fetchItemsShops() async {
    final response = await http.get(
      Uri.parse(
          'https://news.wasiljo.com/public/api/v1/user/shops/${widget
              .id}/subcategory'),
    );
    final jsonRes = json.decode(response.body);
    if (response.statusCode == 200) {
      final shopsList = jsonRes['data']['sub_categories'] as List<dynamic>;
      setState(() {
        isloading = false;
        final itemShops =
        shopsList.map((json) => ItemShopsList.fromJson(json)).toList();
        itemShopsList = itemShops
            .where((element) =>
        element.shop_id == widget.id && searchText.isEmpty ||
            element.title.contains(searchText.toString()) &&
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
        title: "Error Api ItemShop",
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
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchItemsShops());

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
                                fetchItemsShops();
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
                                          widget.popMenuValue1 ??
                                      (widget.addresses?[0].type == 1
                                          ? "Home (${widget.addresses?[0]!
                                          .street.toString()})"
                                          : widget.addresses?[0]!.type ==
                                          2
                                          ? "Work (${widget.addresses?[0]!
                                          .street.toString()})"
                                          : widget.addresses?[0]
                                          .type ==
                                          3
                                          ? "Other (${widget.addresses?[0]!
                                          .street.toString()})"
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
                            itemBuilder: (context) =>
                            [
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
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextWidgets(
                                          text: item.type == 1
                                              ? item.street.toString()
                                              : item.type == 2
                                              ? item.street.toString()
                                              : item.street.toString(),
                                          textOverFlow:
                                          TextOverflow.ellipsis,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        TextWidgets(
                                          text: item.type == 1
                                              ? '${item.city
                                              .toString()} - ${item
                                              .apartment_num.toString()}'
                                              : item.type == 2
                                              ? '${item.city
                                              .toString()} - ${item
                                              .apartment_num.toString()}'
                                              : '${item.city
                                              .toString()} - ${item
                                              .apartment_num.toString()}',
                                          textOverFlow:
                                          TextOverflow.ellipsis,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
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
                      text: 'Water Services',
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
                        fetchItemsShops();
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
                  itemCount: itemShopsList?.length,
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
                              onTap: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  itemShopsList?[index].quantity > 0
                                      ? ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: ImageNetworkWidget(
                                      image:
                                      'https://news.wasiljo.com/${itemShopsList?[index]
                                          .image_url.toString()}',
                                      height: 90,
                                      width: 90,
                                      fit: BoxFit.fitHeight,
                                      errorbuilder:
                                          (BuildContext context,
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
                                            'https://news.wasiljo.com/${itemShopsList?[index]
                                                .image_url.toString()}',
                                            height: 90,
                                            width: 90,
                                            fit: BoxFit.fitHeight,
                                            errorbuilder:
                                                (BuildContext context,
                                                Object exception,
                                                StackTrace?
                                                stackTrace) {
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
                                            text: itemShopsList?[index]
                                                .quantity
                                                .length ==
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
                                        '${itemShopsList?[index].title
                                            .toString()}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff000000),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      TextWidgets(
                                        text:
                                        '${itemShopsList?[index].description
                                            .toString()}',
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          TextWidgets(
                                            text:
                                            'Price : ${itemShopsList?[index]
                                                .price.toString()}',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextWidgets(
                                            text:
                                            'Quantity : ${itemShopsList?[index]
                                                .quantity.toString()}',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
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
        ));
  }
}
