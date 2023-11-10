import 'package:delivery/views/add_new_address.dart';
import 'package:delivery/views/delete_address.dart';
import 'package:delivery/views/shop.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../bindings/address_binding/address_binding.dart';
import '../bindings/cart_binding/cart_binding.dart';
import '../bindings/categorie_binding/categorie_binding.dart';
import '../bindings/checkout_binding/checkout_binding.dart';
import '../bindings/item_shop_binding/item_shop_binding.dart';
import '../bindings/shop_binding/shop_binding.dart';
import '../services/fierbace/firebase_options.dart';
import 'cart.dart';
import 'checkout.dart';
import 'homepage.dart';
import 'item_shop.dart';
import 'splach_screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplachScreen(),
      getPages: [
        GetPage(
          name: "/home",
          page: () => HomePage(),
          binding:BindingsBuilder(() {
            CategorieBinding().dependencies();
            AddressBinding().dependencies();
            CartBinding().dependencies();
          }),
        ),
        GetPage(
          name: "/shops",
          page: () =>   const Shops(),
          binding:BindingsBuilder(() {
            ShopBinding().dependencies();
          }),
        ),
        GetPage(
          name: "/addNewAddress",
          page: () =>  const AddNewAddress(),

        ),
        GetPage(
          name: "/itemShop",
          page: () =>  const ItemShop(),
          binding:BindingsBuilder(() {
            ItemShopBinding().dependencies();
          }),

        ),
        GetPage(
          name: "/cart",
          page: () =>  const Cart(),
        ),
        GetPage(
          name: "/deleteAddress",
          page: () =>  const DeleteAddress(),
        ),
        GetPage(
          name: "/checkout",
          page: () =>  const CheckOut(),
          binding:BindingsBuilder(() {
            CheckOutBinding().dependencies();
          }),
        ),
      ],
    );
  }
}