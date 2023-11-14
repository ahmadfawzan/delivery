import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/services/user/delete_user/delete_user.dart';
import 'package:delivery/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/address_controller/address_controller.dart';
import '../controllers/cart_controller/cart_controller.dart';
import '../controllers/categorie_controller/categorie_controller.dart';
import '../widgets/image_widgets.dart';
import '../widgets/network_image.dart';
import '../widgets/text_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final CategorieController categorieController = Get.find();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AddressController addressController = Get.find();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final CartController cartController = Get.find();

  @override
  void initState() {
    addressController.fetchAddress();
    cartController.addItemToCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SizedBox(
        width: 230,
        child: Drawer(
          backgroundColor: const Color(0xff15CB95),
          child: Padding(
            padding: const EdgeInsets.only(left: 40, top: 100),
            child: ListView(
              children: [
                ListTile(
                  minLeadingWidth: 10,
                  leading: const Icon(
                    Icons.person,
                    size: 25,
                    color: Colors.white,
                  ),
                  title: const TextWidgets(
                    text: 'Profile',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Profile()));
                  },
                ),
                ListTile(
                  minLeadingWidth: 10,
                  leading: const Icon(
                    Icons.delete,
                    size: 25,
                    color: Colors.white,
                  ),
                  title: const TextWidgets(
                    text: 'Delete User',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (!mounted) return;
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      dialogType: DialogType.info,
                      btnOkOnPress: () {
                        DeleteUser(context: context);
                      },
                      btnCancelOnPress: () {},
                      title: "Delete Account",
                      body: const TextWidgets(
                        text: "Are you sure you want to delete your account?",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ).show();
                  },
                ),
                ListTile(
                  minLeadingWidth: 10,
                  leading: const Icon(
                    Icons.delete,
                    size: 25,
                    color: Colors.white,
                  ),
                  title: const TextWidgets(
                    text: 'Delete Address',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Get.toNamed('deleteAddress');
                  },
                ),
                ListTile(
                  minLeadingWidth: 10,
                  leading: const Icon(
                    Icons.login_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                  title: const TextWidgets(
                    text: 'LogOut',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (!mounted) return;
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      dialogType: DialogType.info,
                      btnOkOnPress: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear();
                        Get.offAllNamed("/login");
                        cartController.numberOfItem.value = 0;
                      },
                      btnCancelOnPress: () {},
                      title: "LogOut",
                      body: const TextWidgets(
                        text: "Are you sure you want to LogOut?",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ).show();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, right: 18, left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(builder: (context) {
                  return IconButton(
                      onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      icon: const Icon(
                        Icons.menu,
                        size: 25,
                      ));
                }),
                GetBuilder(
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
          ),
          const SizedBox(
            height: 7,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 235.0),
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
                return addressController.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.only(right: 158.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 160.0),
                        child: SizedBox(
                            width: 150,
                            height: 40,
                            child: PopupMenuButton<String>(
                                color: const Color(0xffEBFAF5),
                                onSelected: (value) {
                                  setState(() {
                                    addressController.popMenuValue = value;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, bottom: 12),
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
                                ),
                                itemBuilder: (context) => [
                                      ...addressController.addressList
                                          .map((item) {
                                        return PopupMenuItem<String>(
                                          padding: const EdgeInsets.all(4),
                                          value: item.type == 1
                                              ? "Home (${item.street.toString()})"
                                              : item.type == 2
                                                  ? "Work (${item.street.toString()})"
                                                  : "Other (${item.street.toString()})",
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextWidgets(
                                                  text: item.type == 1
                                                      ? item.street.toString()
                                                      : item.type == 2
                                                          ? item.street
                                                              .toString()
                                                          : item.street
                                                              .toString(),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                                                  dividerColor: Colors.black,
                                                ),
                                                child: const PopupMenuDivider(
                                                  height: 4,
                                                ),
                                              ),
                                            ],
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
                      );
              }),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            width: double.infinity,
            height: 122,
            child: ImageWidget(
              image: 'assets/images/image6.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: GetBuilder<CategorieController>(
                  init: CategorieController(),
                  builder: (categorieController) {
                    return categorieController.isLoading.value
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: SingleChildScrollView(
                              child: StaggeredGridView.countBuilder(
                                staggeredTileBuilder: (int index) =>
                                    const StaggeredTile.fit(1),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 2,
                                crossAxisSpacing: 4,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 3,
                                    shadowColor: Colors.black,
                                    child: Container(
                                      height: 122,
                                      width: double.infinity,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: StaggeredGridView.countBuilder(
                              staggeredTileBuilder: (int index) =>
                                  const StaggeredTile.fit(1),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              itemCount:
                                  categorieController.categorieList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    categorieController.title =
                                        categorieController
                                            .categorieList[index].title?.en;
                                    categorieController.id = categorieController
                                        .categorieList[index].id;
                                    categorieController.expeditedFees=categorieController
                                        .categorieList[index].expeditedFees??0;
                                    categorieController.deliveryFee=categorieController
                                        .categorieList[index].deliveryFee??0;
                                    categorieController.commesion=categorieController
                                        .categorieList[index].commesion;
                                    Get.toNamed('/shops');
                                  },
                                  child: Card(
                                    elevation: 3,
                                    shadowColor: Colors.black,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                       ImageNetworkWidget(
                                            image:
                                                'https://news.wasiljo.com/${categorieController.categorieList[index].imageUrl}',
                                            fit: BoxFit.fitWidth,
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          child: TextWidgets(
                                            text:
                                                '${categorieController.categorieList[index].title?.en}',
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  })),
          Container(
            width: double.infinity,
            height: 55,
            color: const Color(0xff14CB95),
          )
        ],
      ),
    );
  }
}
