import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/Screen/login.dart';
import 'package:delivery/Screen/profile.dart';
import 'package:delivery/Screen/shops.dart';
import 'package:delivery/Utils/Ui/image_widgets.dart';
import 'package:delivery/Utils/Ui/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../Server/api_categories_response.dart';
import '../Server/api_delete_account_response.dart';
import '../Utils/Helper/list_data_address_api.dart';
import '../Utils/Helper/list_data_categories_api.dart';
import '../Utils/Ui/network_image.dart';
import 'add_new_address.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Categories>> fetchcategories;
  List? addresses;
  String? popMenuValue;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isloading = true;

  Future fetchAddresses() async {
    SharedPreferences sharedtoken = await SharedPreferences.getInstance();
    String? token = sharedtoken.getString('token');
    final response = await http.get(
      Uri.parse('https://news.wasiljo.com/public/api/v1/user/addresses'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final jsonRes = json.decode(response.body);
    if (response.statusCode == 200) {
      final addressList = jsonRes['data']['addresses'] as List<dynamic>;

      setState(() {
        addresses = addressList.map((json) => Address.fromJson(json)).toList();
        isloading = false;
      });
    } else {
      jsonRes('error');
    }
  }

  @override
  void initState() {
    setState(() {
      fetchcategories = fetchCategories();
    });

    fetchAddresses();
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
                        DeleteAccount(context: context);
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
                                      ? '${item.city.toString()} - ${item.apartment_num.toString()}'
                                      : item.type == 2
                                      ? '${item.city.toString()} - ${item.apartment_num.toString()}'
                                      : '${item.city.toString()} - ${item.apartment_num.toString()}',
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
            child: FutureBuilder<List<Categories>>(
              future: fetchcategories,
              builder: (context, AsyncSnapshot<List<Categories>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Shimmer.fromColors(
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
                  );
                } else {
                  return SingleChildScrollView(
                    child: StaggeredGridView.countBuilder(
                      staggeredTileBuilder: (index) =>
                          StaggeredTile.count(1, index.isEven ? 1.3 : 1.6),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            int id = snapshot.data![index].id;
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: ImageNetworkWidget(
                                    image:
                                    'https://news.wasiljo.com/${snapshot.data![index].image}',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: TextWidgets(
                                    text: snapshot.data![index].title,
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
                }
              },
            ),
          ),
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