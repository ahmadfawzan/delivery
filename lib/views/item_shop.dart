import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/controllers/item_shop_controller/item_shop_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/address_controller/address_controller.dart';
import '../controllers/cart_controller/cart_controller.dart';
import '../controllers/categorie_controller/categorie_controller.dart';
import '../controllers/shop_controller/shop_controller.dart';
import '../widgets/material_button_widgets.dart';
import '../widgets/network_image.dart';
import '../widgets/text_form_field_widgets.dart';
import '../widgets/text_widgets.dart';
import 'add_new_address.dart';

class ItemShop extends StatefulWidget {
  const ItemShop({
    super.key,
  });

  @override
  State<ItemShop> createState() => _ItemShopState();
}

class _ItemShopState extends State<ItemShop> {
  final AddressController addressController = Get.find();
  final ItemShopController itemShopController = Get.find();
  final ShopController shopController = Get.find();
  final CategorieController categorieController = Get.find();
  final CartController cartController = Get.find();

  @override
  void initState() {
    itemShopController.fetchItemShop();
    addressController.fetchAddress();
    super.initState();
  }

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
                                  itemShopController.itemShopList.clear(),
                                  shopController.fetchShop(),
                                  itemShopController.itemShopSearch.clear(),
                                  itemShopController.searchText.value = '',
                                  itemShopController.isLoading.value = true,
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
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      addressController.addressList.isEmpty
                                          ? const TextWidgets(
                                              text: 'No Loction',
                                              fontWeight: FontWeight.bold,
                                              textOverFlow:
                                                  TextOverflow.ellipsis,
                                              fontSize: 15,
                                            )
                                          : Expanded(
                                              child: TextWidgets(
                                              text: addressController
                                                      .popMenuValue ??
                                                  (addressController
                                                              .addressList[0]
                                                              .type ==
                                                          1
                                                      ? "Home (${addressController.addressList[0].street.toString()})"
                                                      : addressController
                                                                  .addressList[
                                                                      0]
                                                                  .type ==
                                                              2
                                                          ? "Work (${addressController.addressList[0].street.toString()})"
                                                          : addressController
                                                                      .addressList[
                                                                          0]
                                                                      .type ==
                                                                  3
                                                              ? "Other (${addressController.addressList[0].street.toString()})"
                                                              : ''),
                                              fontWeight: FontWeight.bold,
                                              textOverFlow:
                                                  TextOverflow.ellipsis,
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
                                        ...addressController.addressList
                                            .map((item) {
                                          return PopupMenuItem<String>(
                                            value: item.type == 1
                                                ? "Home (${item.street.toString()})"
                                                : item.type == 2
                                                    ? "Work (${item.street.toString()})"
                                                    : "Other (${item.street.toString()})",
                                            child: Container(
                                              width: 190,
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
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
                                                            ? item.street
                                                                .toString()
                                                            : item.street
                                                                .toString(),
                                                    textOverFlow:
                                                        TextOverflow.ellipsis,
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
                                                    textOverFlow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Theme(
                                                    data: ThemeData(
                                                      dividerColor:
                                                          Colors.black,
                                                    ),
                                                    child:
                                                        const PopupMenuDivider(
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
                        );
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  GetBuilder<ItemShopController>(
                      init: ItemShopController(),
                      builder: (itemShopController) => Padding(
                            padding: const EdgeInsets.only(right: 203.0),
                            child: itemShopController.isLoading.value
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[350]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.white,
                                      height: 20,
                                      width: 100,
                                    ))
                                : Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            categorieController.title?.length ==
                                                    11
                                                ? 15
                                                : 0),
                                    child: TextWidgets(
                                      text:
                                          categorieController.title.toString(),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff676666),
                                    ),
                                  ),
                          )),
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
                        itemShopController.searchText.value = value;
                        itemShopController.SearchitemShop();
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
            GetBuilder<ItemShopController>(
                init: ItemShopController(),
                builder: (itemShopController) => Expanded(
                      child: itemShopController.searchText.value.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.only(top: 7),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  itemShopController.itemShopSearch.length,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      height: 120,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          itemShopController
                                                      .itemShopSearch[index]
                                                      .quantity !=
                                                  0
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: ImageNetworkWidget(
                                                    image:
                                                        'https://news.wasiljo.com/${itemShopController.itemShopSearch[index].imageUrl.toString()}',
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
                                                              'https://news.wasiljo.com/${itemShopController.itemShopSearch[index].imageUrl.toString()}',
                                                          height: 90,
                                                          width: 90,
                                                          fit: BoxFit.fitHeight,
                                                          errorbuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Object
                                                                      exception,
                                                                  StackTrace?
                                                                      stackTrace) {
                                                            return Image.asset(
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
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: TextWidgets(
                                                          text: itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .quantity ==
                                                                  0
                                                              ? "Not Available"
                                                              : "",
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
                                          SizedBox(
                                            width: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextWidgets(
                                                  text: itemShopController
                                                      .itemShopSearch[index]
                                                      .title!
                                                      .en!
                                                      .toString(),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xff000000),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                TextWidgets(
                                                  text: itemShopController
                                                      .itemShopSearch[index]
                                                      .description
                                                      .en
                                                      .toString(),
                                                  fontSize: 11,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                TextWidgets(
                                                  text:
                                                      'Price : ${itemShopController.itemShopSearch[index].price}',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                TextWidgets(
                                                  text:
                                                      'Quantity : ${itemShopController.itemShopSearch[index].quantity}',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          GetBuilder(
                                              init: CartController(),
                                              builder: (cartController) =>
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 65.0),
                                                    child: GetBuilder(
                                                      init: ShopController(),
                                                      builder: (shopController) =>
                                                          MaterialButtonWidgets(
                                                        onPressed: () async {
                                                          itemShopController
                                                              .fetchItemShop();
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          List<String>?
                                                              savedItems =
                                                              prefs.getStringList(
                                                                  'cartItems');
                                                          final existingItem =
                                                              savedItems?.where(
                                                                  (element) {
                                                            try {
                                                              final Map<String,
                                                                      dynamic>
                                                                  itemMap =
                                                                  json.decode(
                                                                      element);
                                                              final int itemId =
                                                                  int.tryParse(itemMap[
                                                                              'id']
                                                                          .toString()) ??
                                                                      0;
                                                              return itemId ==
                                                                  itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .id;
                                                            } catch (e) {
                                                              return false;
                                                            }
                                                          });
                                                          if (existingItem !=
                                                                  null &&
                                                              existingItem
                                                                  .isNotEmpty) {
                                                            if (mounted) {
                                                              AwesomeDialog(
                                                                animType: AnimType
                                                                    .leftSlide,
                                                                dialogType:
                                                                    DialogType
                                                                        .error,
                                                                btnOkOnPress:
                                                                    () {},
                                                                btnCancelOnPress:
                                                                    () {},
                                                                title:
                                                                    'Item is already in the cart!',
                                                                body:
                                                                    const TextWidgets(
                                                                  text:
                                                                      'Item is already in the cart!',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                context:
                                                                    context,
                                                              ).show();
                                                            }
                                                          } else {
                                                            if( cartController.itemCart.isEmpty){
                                                              cartController.counter.clear();
                                                            }
                                                            cartController
                                                                .itemCart
                                                                .add({
                                                              "id": itemShopController
                                                                  .itemShopSearch[
                                                                      index]
                                                                  .id,
                                                              "imageUrl":
                                                                  itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .imageUrl,
                                                              "title": [
                                                                {
                                                                  "en": itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .title!
                                                                      .en,
                                                                  "ar": itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .title!
                                                                      .ar,
                                                                }
                                                              ],
                                                              "description": [
                                                                {
                                                                  "en": itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .description!
                                                                      .en,
                                                                  "ar": itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .description!
                                                                      .ar,
                                                                }
                                                              ],
                                                              "price":
                                                                  itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .price,
                                                              "quantity":
                                                                  itemShopController
                                                                      .itemShopSearch[
                                                                          index]
                                                                      .quantity,
                                                            });
                                                            cartController.addItemToCart();
                                                            cartController
                                                                .counter
                                                                .add(0);
                                                            cartController.saveCounterValues();
                                                            if (mounted) {
                                                              AwesomeDialog(
                                                                animType: AnimType
                                                                    .leftSlide,
                                                                dialogType:
                                                                    DialogType
                                                                        .success,
                                                                btnOkOnPress:
                                                                    () {},
                                                                btnCancelOnPress:
                                                                    () {},
                                                                title:
                                                                    'Item added to the cart!',
                                                                body:
                                                                    const TextWidgets(
                                                                  text:
                                                                      'Item added to the cart!',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                context:
                                                                    context,
                                                              ).show();
                                                            }
                                                          }
                                                        },
                                                        height: 30,
                                                        textColor: Colors.white,
                                                        color: const Color(
                                                            0xff15CB95),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: const TextWidgets(
                                                            text: "Add To Cart",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 7),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: itemShopController.itemShopList.length,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      height: 120,
                                      child: itemShopController.isLoading.value
                                          ? Shimmer.fromColors(
                                              baseColor: Colors.grey[350]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                color: Colors.white,
                                                height: 120,
                                                width: double.infinity,
                                              ))
                                          : Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                itemShopController
                                                            .itemShopList[index]
                                                            .quantity !=
                                                        0
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            ImageNetworkWidget(
                                                          image:
                                                              'https://news.wasiljo.com/${itemShopController.itemShopList[index].imageUrl.toString()}',
                                                          height: 90,
                                                          width: 90,
                                                          fit: BoxFit.fitHeight,
                                                          errorbuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Object
                                                                      exception,
                                                                  StackTrace?
                                                                      stackTrace) {
                                                            return Image.asset(
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
                                                                    'https://news.wasiljo.com/${itemShopController.itemShopList[index].imageUrl.toString()}',
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
                                                                    height: 90,
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
                                                                text: itemShopController
                                                                            .itemShopList[index]
                                                                            .quantity ==
                                                                        0
                                                                    ? "Not Available"
                                                                    : "Busy",
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.5,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextWidgets(
                                                        text: itemShopController
                                                            .itemShopList[index]
                                                            .title!
                                                            .en
                                                            .toString(),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      TextWidgets(
                                                        text: itemShopController
                                                            .itemShopList[index]
                                                            .description!
                                                            .en
                                                            .toString(),
                                                        fontSize: 11,
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      TextWidgets(
                                                        text:
                                                            'Price : ${itemShopController.itemShopList[index].price}',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      TextWidgets(
                                                        text:
                                                            'Quantity : ${itemShopController.itemShopList[index].quantity.toString()}',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                GetBuilder(
                                                  init: CartController(),
                                                  builder: (cartController) =>
                                                      Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 65.0),
                                                    child: GetBuilder(
                                                      init: ShopController(),
                                                      builder: (shopController) =>
                                                          MaterialButtonWidgets(
                                                        onPressed: () async {
                                                          itemShopController
                                                              .fetchItemShop();
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          List<String>?
                                                              savedItems =
                                                              prefs.getStringList(
                                                                  'cartItems');
                                                          final existingItem =
                                                              savedItems?.where(
                                                                  (element) {
                                                            try {
                                                              final Map<String,
                                                                      dynamic>
                                                                  itemMap =
                                                                  json.decode(
                                                                      element);
                                                              final int itemId =
                                                                  int.tryParse(itemMap[
                                                                              'id']
                                                                          .toString()) ??
                                                                      0;
                                                              return itemId ==
                                                                  itemShopController
                                                                      .itemShopList[
                                                                          index]
                                                                      .id;
                                                            } catch (e) {
                                                              return false;
                                                            }
                                                          });
                                                          if (existingItem !=
                                                                  null &&
                                                              existingItem
                                                                  .isNotEmpty) {
                                                            if (mounted) {
                                                              AwesomeDialog(
                                                                animType: AnimType
                                                                    .leftSlide,
                                                                dialogType:
                                                                    DialogType
                                                                        .error,
                                                                btnOkOnPress:
                                                                    () {},
                                                                btnCancelOnPress:
                                                                    () {},
                                                                title:
                                                                    'Item is already in the cart!',
                                                                body:
                                                                    const TextWidgets(
                                                                  text:
                                                                      'Item is already in the cart!',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                context:
                                                                    context,
                                                              ).show();
                                                            }
                                                          } else {
                                                            if( cartController.itemCart.isEmpty){
                                                              cartController.counter.clear();
                                                            }
                                                            cartController
                                                                .itemCart
                                                                .add({
                                                              "id": itemShopController
                                                                  .itemShopList[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              "imageUrl":
                                                                  itemShopController
                                                                      .itemShopList[
                                                                          index]
                                                                      .imageUrl,
                                                              "title": [
                                                                {
                                                                  "en": itemShopController
                                                                      .itemShopList[
                                                                          index]
                                                                      .title!
                                                                      .en,
                                                                  "ar": itemShopController
                                                                      .itemShopList[
                                                                          index]
                                                                      .title!
                                                                      .ar,
                                                                }
                                                              ],
                                                              "description": [
                                                                {
                                                                  "en": itemShopController
                                                                      .itemShopList[
                                                                          index]
                                                                      .description!
                                                                      .en,
                                                                  "ar": itemShopController
                                                                      .itemShopList[
                                                                          index]
                                                                      .description!
                                                                      .ar,
                                                                }
                                                              ],
                                                              "price":
                                                                  itemShopController
                                                                      .itemShopList[
                                                                          index]
                                                                      .price,
                                                              "quantity":
                                                                  itemShopController
                                                                      .itemShopList[
                                                                          index]
                                                                      .quantity,
                                                            });
                                                            cartController.addItemToCart();
                                                            cartController
                                                                .counter
                                                                .add(0);
                                                            cartController.saveCounterValues();
                                                            if (mounted) {
                                                              AwesomeDialog(
                                                                animType: AnimType
                                                                    .leftSlide,
                                                                dialogType:
                                                                    DialogType
                                                                        .success,
                                                                btnOkOnPress:
                                                                    () {},
                                                                btnCancelOnPress:
                                                                    () {},
                                                                title:
                                                                    'Item added to the cart!',
                                                                body:
                                                                    const TextWidgets(
                                                                  text:
                                                                      'Item added to the cart!',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                context:
                                                                    context,
                                                              ).show();
                                                            }
                                                          }
                                                        },
                                                        height: 30,
                                                        textColor: Colors.white,
                                                        color: const Color(
                                                            0xff15CB95),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: const TextWidgets(
                                                            text: "Add To Cart",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                );
                              }),
                    )),
          ],
        ));
  }
}
