import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/services/user/delete_user/delete_user.dart';
import 'package:delivery/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/address_controller/address_controller.dart';
import '../controllers/categorie_controller/categorie_controller.dart';
import '../widgets/image_widgets.dart';
import '../widgets/network_image.dart';
import '../widgets/text_widgets.dart';
import 'add_new_address.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final CategorieController categorieController = Get.find();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AddressController addressController = Get.find();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    addressController.fetchAddress();
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
                  return IconButton(
                      onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      icon: const Icon(
                        Icons.menu,
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
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.count(
                                        1, index.isEven ? 1.3 : 1.6),
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
                              staggeredTileBuilder: (index) =>
                                  StaggeredTile.count(
                                      1, index.isEven ? 1.3 : 1.6),
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
                                    categorieController.title= categorieController.categorieList[index].title?.en;
                                    categorieController.id=categorieController.categorieList[index].id;
                                    Get.toNamed('/shops');
                                  },
                                  child: Card(
                                    elevation: 3,
                                    shadowColor: Colors.black,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 25.0),
                                          child: ImageNetworkWidget(
                                            image:
                                                'https://news.wasiljo.com/${categorieController.categorieList[index].imageUrl}',
                                            fit: BoxFit.fitWidth,
                                          ),
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
