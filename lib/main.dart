import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xb/Features/Auth/Screen/SplashScreen.dart';
import 'package:xb/Nav/BottomNav.dart';
import 'Controller/BottomNavController.dart';
import 'Controller/CartController.dart';
import 'Controller/FavoriteController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController());
  Get.put(FavoriteController());
  Get.put(BottomNavController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BottomNavBar(),
    );
  }
}
