import 'package:delivery/bindings/home_binding/home_binding.dart';
import 'package:delivery/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/fierbace/firebase_options.dart';
import 'cart.dart';
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
        GetPage(name: "/cart", page: () => const Cart()),
        GetPage(name: "/home", page: ()=>  HomePage(),binding: HomeBinding())
      ],
    );
  }
}
