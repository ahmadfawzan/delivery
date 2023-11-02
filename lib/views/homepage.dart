import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/controllers/categories_controllers/categories_controllers.dart';
import 'package:delivery/view/profile.dart';
import 'package:delivery/view/shops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../model/address_model/address_model.dart';
import '../model/categories_model/categories_model.dart';
import '../services/categories/get_categories/get_categories.dart';
import '../services/user/delete_user/delete_user.dart';
import '../widget/image_widgets.dart';
import '../widget/network_image.dart';
import '../widget/text_widgets.dart';
import 'add_new_address.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  CategoriesControllers categoriesControllers = Get.find();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? popMenuValue;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isloading = true;



  @override
  void initState() {
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
                        SharedPreferences sharedtoken =
                            await SharedPreferences.getInstance();
                        await sharedtoken.clear();
                        const storage = FlutterSecureStorage();
                        await storage.deleteAll();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Login()));
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
                  return isloading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: IconButton(
                              onPressed: () =>
                                  scaffoldKey.currentState?.openDrawer(),
                              icon: const Icon(
                                Icons.menu,
                                size: 25,
                              )),
                        )
                      : IconButton(
                          onPressed: () =>
                              scaffoldKey.currentState?.openDrawer(),
                          icon: const Icon(
                            Icons.menu,
                            size: 25,
                          ));
                }),
                isloading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_bag,
                            color: Color(0xff4E5156),
                            size: 25,
                          ),
                        ))
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_bag,
                          color: Color(0xff4E5156),
                          size: 25,
                        ),
                      )
              ],
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          isloading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 235.0),
                    child: TextWidgets(
                      text: "Delvering To",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(right: 235.0),
                  child: TextWidgets(
                    text: "Delvering To",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
          isloading
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
                              popMenuValue = value;
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 2.0, bottom: 12),
                            child: Row(
                              children: [
                                addresses?.length == 0
                                    ? const Text('')
                                    : Expanded(
                                        child: TextWidgets(
                                        text: popMenuValue ??
                                            (addresses?[0].type == 1
                                                ? "Home (${addresses?[0].street.toString()})"
                                                : addresses?[0].type == 2
                                                    ? "Work (${addresses?[0].street.toString()})"
                                                    : addresses?[0].type == 3
                                                        ? "Other (${addresses?[0].street.toString()})"
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
                          ),
                          itemBuilder: (context) => [
                                ...?addresses?.map((item) {
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
            height: 10,
          ),
          isloading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 122,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(
                  width: double.infinity,
                  height: 122,
                  child: ImageWidget(
                    image: 'assets/images/image6.png',
                    fit: BoxFit.cover,
                  ),
                ),
          Expanded(
              child: isloading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: SingleChildScrollView(
                        child: StaggeredGridView.countBuilder(
                          staggeredTileBuilder: (index) =>
                              StaggeredTile.count(1, index.isEven ? 1.3 : 1.6),
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
                  : GetBuilder<CategoriesControllers>(
                      init: CategoriesControllers(),
                      builder: (categoriesControllers) => SingleChildScrollView(
                        child: StaggeredGridView.countBuilder(
                          staggeredTileBuilder: (index) =>
                              StaggeredTile.count(1, index.isEven ? 1.3 : 1.6),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          itemCount:
                              categoriesControllers.categoriesList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                int? id = categoriesControllers
                                    .categoriesList[index].id;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Shops(
                                      id: id,
                                      addresses: addresses,
                                      popMenuValue: popMenuValue,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 3,
                                shadowColor: Colors.black,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: ImageNetworkWidget(
                                        image:
                                            'https://news.wasiljo.com/${categoriesControllers.categoriesList[index].imageUrl}',
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: TextWidgets(
                                        text:
                                            '${categoriesControllers.categoriesList[index].title?.en}',
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
                      ),
                    )),
          isloading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    color: const Color(0xff14CB95),
                  ))
              : Container(
                  width: double.infinity,
                  height: 55,
                  color: const Color(0xff14CB95),
                )
        ],
      ),
    );
  }
}
