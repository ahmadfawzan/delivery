import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/address_controller/address_controller.dart';
import '../controllers/cart_controller/cart_controller.dart';
import '../controllers/shop_controller/shop_controller.dart';
import '../widgets/network_image.dart';
import '../widgets/text_form_field_widgets.dart';
import '../widgets/text_widgets.dart';

class Shops extends StatefulWidget {
  const Shops({Key? key}) : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  final AddressController addressController = Get.find();
  final ShopController shopController = Get.find();
  final CartController cartController = Get.find();
  @override
  void initState() {
    shopController.fetchShop();
    addressController.fetchAddress();
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
                          onPressed: () => {
                                addressController.fetchAddress(),
                                shopController.shopList.clear(),
                                shopController.shopSearch.clear(),
                                shopController.searchText.value='',
                                shopController.isLoading.value=true,
                                Get.back(),
                              },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 25,
                          ));
                    }),
                    GetBuilder<CartController>(
                        init: CartController(),
                        builder: (cartController) {
                          return Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.toNamed("/cart");
                                },
                                icon: const Icon(
                                  Icons.shopping_bag,
                                  color: Color(0xff4E5156),
                                  size: 25,
                                ),
                              ),
                              Positioned(
                                right: 4,
                                top: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff14CB95),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${cartController.numberOfItem}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
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
    GetBuilder<AddressController>(
    init: AddressController(),
    builder: (addressController) {
    return Padding(
                  padding: const EdgeInsets.only(right: 151.0),
                  child: SizedBox(
                      width: 150,
                      height: 30,
                      child: PopupMenuButton<String>(
                          color: const Color(0xffEBFAF5),
                          onSelected: (value) {
                            setState(() {
                              addressController.popMenuValue = value;
                              shopController.fetchShop();
                            });
                          },
                          child: Row(
                            children: [
                              addressController.addressList.isEmpty
                                  ? const TextWidgets(
                                      text: 'No Loction',
                                      fontWeight: FontWeight.bold,
                                      textOverFlow: TextOverflow.ellipsis,
                                      fontSize: 15,
                                    )
                                  : Expanded(
                                      child: TextWidgets(
                                      text: addressController.popMenuValue ??
                                          (addressController
                                                      .addressList[0].type ==
                                                  1
                                              ? "Home (${addressController.addressList[0].street.toString()})"
                                              : addressController.addressList[0]
                                                          .type ==
                                                      2
                                                  ? "Work (${addressController.addressList[0].street.toString()})"
                                                  : addressController
                                                              .addressList[0]
                                                              .type ==
                                                          3
                                                      ? "Other (${addressController.addressList[0].street.toString()})"
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
                                ...addressController.addressList.map((item) {
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
                                    Get.toNamed("/addNewAddress");
                                  },
                                )
                              ])),
                );}),
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
                      shopController.searchText.value = value;
                      shopController.SearchShop();
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
          addressController.addressList.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 150.0),
                  child: TextWidgets(
                    text: "No Loction Please Add New Address",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                )
              : GetBuilder(
                  init: ShopController(),
                  builder: (shopController) => Expanded(
                        child: shopController.searchText.value.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.only(top: 7),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: shopController.shopSearch.length,
                                itemBuilder: (context, index) {
                                  return SingleChildScrollView(
                                      child: Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      height: 120,
                                      child: shopController.shopSearch[index]
                                          .open ==
                                          1? InkWell(
                                        splashColor: Colors.grey,
                                        onTap: () {
                                          shopController.id = shopController.shopSearch[index].id;
                                          Get.toNamed('/itemShop');
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            shopController.shopSearch[index]
                                                        .open ==
                                                    1
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: ImageNetworkWidget(
                                                      image:
                                                          'https://news.wasiljo.com/${shopController.shopSearch[index].license.toString()}',
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
                                                  )
                                                : SizedBox(
                                                    width: 90,
                                                    height: 90,
                                                    child: Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              ImageNetworkWidget(
                                                            image:
                                                                'https://news.wasiljo.com/${shopController.shopSearch[index].license.toString()}',
                                                            height: 90,
                                                            width: 90,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            errorbuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                'assets/images/image2.png',
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                                height: 90,
                                                                width: 90,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: const Opacity(
                                                            opacity: 0.5,
                                                            child: ModalBarrier(
                                                                dismissible:
                                                                    false,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: TextWidgets(
                                                            text: shopController
                                                                        .shopSearch[
                                                                            index]
                                                                        .open ==
                                                                    0
                                                                ? "Closed"
                                                                : "Busy",
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                  text: shopController
                                                      .shopSearch[index]
                                                      .shopNameEn
                                                      .toString(),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                TextWidgets(
                                                  text: shopController
                                                      .shopSearch[index]
                                                      .address
                                                      .toString(),
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
                                                      text: shopController
                                                          .shopSearch[index]
                                                          .rating
                                                          .toString(),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    TextWidgets(
                                                      text:
                                                          '(${shopController.shopSearch[index].totalRating.toString()}+ Ratings)',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ):Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          shopController.shopSearch[index]
                                              .open ==
                                              1
                                              ? ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                            child: ImageNetworkWidget(
                                              image:
                                              'https://news.wasiljo.com/${shopController.shopSearch[index].license.toString()}',
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
                                          )
                                              : SizedBox(
                                            width: 90,
                                            height: 90,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10),
                                                  child:
                                                  ImageNetworkWidget(
                                                    image:
                                                    'https://news.wasiljo.com/${shopController.shopSearch[index].license.toString()}',
                                                    height: 90,
                                                    width: 90,
                                                    fit: BoxFit
                                                        .fitHeight,
                                                    errorbuilder:
                                                        (BuildContext
                                                    context,
                                                        Object
                                                        exception,
                                                        StackTrace?
                                                        stackTrace) {
                                                      return Image
                                                          .asset(
                                                        'assets/images/image2.png',
                                                        fit: BoxFit
                                                            .fitHeight,
                                                        height: 90,
                                                        width: 90,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10),
                                                  child: const Opacity(
                                                    opacity: 0.5,
                                                    child: ModalBarrier(
                                                        dismissible:
                                                        false,
                                                        color: Colors
                                                            .black),
                                                  ),
                                                ),
                                                Center(
                                                  child: TextWidgets(
                                                    text: shopController
                                                        .shopSearch[
                                                    index]
                                                        .open ==
                                                        0
                                                        ? "Closed"
                                                        : "Busy",
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold,
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
                                                text: shopController
                                                    .shopSearch[index]
                                                    .shopNameEn
                                                    .toString(),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                const Color(0xff000000),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              TextWidgets(
                                                text: shopController
                                                    .shopSearch[index]
                                                    .address
                                                    .toString(),
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
                                                    text: shopController
                                                        .shopSearch[index]
                                                        .rating
                                                        .toString(),
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  TextWidgets(
                                                    text:
                                                    '(${shopController.shopSearch[index].totalRating.toString()}+ Ratings)',
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                                })
                            : ListView.builder(
                                padding: const EdgeInsets.only(top: 7),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: shopController.shopList.length,
                                itemBuilder: (context, index) {
                                  return SingleChildScrollView(
                                      child: Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      height: 120,
                                      child: shopController.isLoading.value
                                          ? Shimmer.fromColors(
                                              baseColor: Colors.grey[350]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                color: Colors.white,
                                                height: 120,
                                                width: double.infinity,
                                              ))
                                          : shopController.shopList[index]
                                          .open ==
                                          0
                                          ? InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () {
                                               shopController.id = shopController.shopList[index].id;
                                               Get.toNamed('/itemShop');
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    width: 25,
                                                  ),
                                                  shopController.shopList[index]
                                                              .open ==
                                                          1
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              ImageNetworkWidget(
                                                            image:
                                                                'https://news.wasiljo.com/${shopController.shopList[index].license.toString()}',
                                                            height: 90,
                                                            width: 90,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            errorbuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                'assets/images/image2.png',
                                                                fit: BoxFit
                                                                    .fitHeight,
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
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    ImageNetworkWidget(
                                                                  image:
                                                                      'https://news.wasiljo.com/${shopController.shopList[index].license.toString()}',
                                                                  height: 90,
                                                                  width: 90,
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  errorbuilder: (BuildContext
                                                                          context,
                                                                      Object
                                                                          exception,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    return Image
                                                                        .asset(
                                                                      'assets/images/image2.png',
                                                                      fit: BoxFit
                                                                          .fitHeight,
                                                                      height:
                                                                          90,
                                                                      width: 90,
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    const Opacity(
                                                                  opacity: 0.5,
                                                                  child: ModalBarrier(
                                                                      dismissible:
                                                                          false,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                              Center(
                                                                child:
                                                                    TextWidgets(
                                                                  text: shopController
                                                                              .shopList[index]
                                                                              .open ==
                                                                          0
                                                                      ? "Closed"
                                                                      : "Busy",
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      15.5,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextWidgets(
                                                        text: shopController
                                                            .shopList[index]
                                                            .shopNameEn
                                                            .toString(),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      TextWidgets(
                                                        text: shopController
                                                            .shopList[index]
                                                            .address
                                                            .toString(),
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
                                                            color: Color(
                                                                0xff15CB95),
                                                            size: 19,
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          TextWidgets(
                                                            text: shopController
                                                                .shopList[index]
                                                                .rating
                                                                .toString(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          TextWidgets(
                                                            text:
                                                                '(${shopController.shopList[index].totalRating.toString()}+ Ratings)',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ):Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          shopController.shopList[index]
                                              .open ==
                                              1
                                              ? ClipRRect(
                                            borderRadius:
                                            BorderRadius
                                                .circular(10),
                                            child:
                                            ImageNetworkWidget(
                                              image:
                                              'https://news.wasiljo.com/${shopController.shopList[index].license.toString()}',
                                              height: 90,
                                              width: 90,
                                              fit: BoxFit
                                                  .fitHeight,
                                              errorbuilder:
                                                  (BuildContext
                                              context,
                                                  Object
                                                  exception,
                                                  StackTrace?
                                                  stackTrace) {
                                                return Image
                                                    .asset(
                                                  'assets/images/image2.png',
                                                  fit: BoxFit
                                                      .fitHeight,
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
                                                  BorderRadius
                                                      .circular(
                                                      10),
                                                  child:
                                                  ImageNetworkWidget(
                                                    image:
                                                    'https://news.wasiljo.com/${shopController.shopList[index].license.toString()}',
                                                    height: 90,
                                                    width: 90,
                                                    fit: BoxFit
                                                        .fitHeight,
                                                    errorbuilder: (BuildContext
                                                    context,
                                                        Object
                                                        exception,
                                                        StackTrace?
                                                        stackTrace) {
                                                      return Image
                                                          .asset(
                                                        'assets/images/image2.png',
                                                        fit: BoxFit
                                                            .fitHeight,
                                                        height:
                                                        90,
                                                        width: 90,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10),
                                                  child:
                                                  const Opacity(
                                                    opacity: 0.5,
                                                    child: ModalBarrier(
                                                        dismissible:
                                                        false,
                                                        color: Colors
                                                            .black),
                                                  ),
                                                ),
                                                Center(
                                                  child:
                                                  TextWidgets(
                                                    text: shopController
                                                        .shopList[index]
                                                        .open ==
                                                        0
                                                        ? "Closed"
                                                        : "Busy",
                                                    color: Colors
                                                        .white,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize:
                                                    15.5,
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
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextWidgets(
                                                text: shopController
                                                    .shopList[index]
                                                    .shopNameEn
                                                    .toString(),
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: const Color(
                                                    0xff000000),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              TextWidgets(
                                                text: shopController
                                                    .shopList[index]
                                                    .address
                                                    .toString(),
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
                                                    color: Color(
                                                        0xff15CB95),
                                                    size: 19,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  TextWidgets(
                                                    text: shopController
                                                        .shopList[index]
                                                        .rating
                                                        .toString(),
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  TextWidgets(
                                                    text:
                                                    '(${shopController.shopList[index].totalRating.toString()}+ Ratings)',
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                                }),
                      )),
        ],
      ),
    );
  }
}
