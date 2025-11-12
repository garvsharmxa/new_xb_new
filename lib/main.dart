import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xb/Features/Auth/Screen/SplashScreen.dart';
import 'package:xb/Nav/BottomNav.dart';
import 'Controller/BottomNavController.dart';
import 'Controller/CartController.dart';
import 'Controller/FavoriteController.dart';
import 'Controller/OrderController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize controllers
  Get.put(CartController());
  Get.put(FavoriteController());
  Get.put(BottomNavController());
  Get.put(OrderController());
  
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
