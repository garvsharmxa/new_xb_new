import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../Controller/BottomNavController.dart';
import '../Features/Fav/FavScreen.dart';
import '../Features/HomeScreen/HomeScreen.dart';
import '../Features/PastOrder/PastOrdersScreen.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final BottomNavController navController = Get.find();

  final List<Widget> screens = const [
    HomeScreen(),
    FavScreen(),
    PastOrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color activeColor = Color(0xFFC2262D);

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: screens[navController.currentIndex.value],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 20.0,
          ), // Add bottom padding here
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ), // Optional: add rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.6),
                    width: 1.5,
                  ),
                ),

                height: 75,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ), // Optional: add side margins
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNavItem(
                      icon: Icons.home_rounded,
                      label: "Home",
                      index: 0,
                      activeColor: activeColor,
                    ),
                    buildNavItem(
                      icon: Icons.favorite_rounded,
                      label: "Favorites",
                      index: 1,
                      activeColor: activeColor,
                    ),
                    buildNavItem(
                      icon: FontAwesomeIcons.shoppingBag,
                      label: "Orders",
                      index: 2,
                      activeColor: activeColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required Color activeColor,
  }) {
    final bool isSelected = navController.currentIndex.value == index;

    return GestureDetector(
      onTap: () => navController.changeIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: isSelected ? 8 : 2,
        ),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    activeColor.withOpacity(0.2),
                    activeColor.withOpacity(0.1),
                  ],
                ),
                border: Border.all(
                  color: activeColor.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              transform: Matrix4.identity()
                ..scale(isSelected ? 1.1 : 1.0)
                ..rotateZ(isSelected ? 0.05 : 0),
              child: Icon(
                icon,
                size: isSelected ? 26 : 24,
                color: isSelected ? activeColor : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? activeColor : Colors.black87,
                fontSize: isSelected ? 12 : 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: isSelected ? 0.5 : 0,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
