import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/BottomNavController.dart';
import 'Features/Fav/FavScreen.dart';
import 'Features/HomeScreen/HomeScreen.dart';
import 'Features/PastOrder/PastOrdersScreen.dart';
import 'Nav/BottomNav.dart';


class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final BottomNavController navController = Get.put(BottomNavController());

  final List<Widget> screens = const [
    HomeScreen(),
    FavScreen(),
    PastOrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      body: screens[navController.currentIndex.value],
      bottomNavigationBar: BottomNavBar(),
    ));
  }
}
