import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:xb/Features/HomeScreen/HomeScreen.dart';

import '../../Controller/BottomNavController.dart';
import '../../Nav/BottomNav.dart';
import '../../models/OnBoardContent.dart';
import '../Fav/FavScreen.dart';
import '../PastOrder/PastOrdersScreen.dart';

class GettingStartedScreen extends StatefulWidget {
  final token;
  final college;
  const GettingStartedScreen({super.key, this.token, this.college});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  String token = "";

  final List<Widget> pages = [
    HomeScreen(),
    FavScreen(),
    PastOrdersScreen(), // Assuming you have a PastOrdersScreen widget
  ];

  final BottomNavController navController = Get.find<BottomNavController>();

  var image = Image(
    errorBuilder: (context, error, stackTrace) => const Placeholder(),
    image: FileImage(File('assets/images/Group_1.png'))..evict(),
  );
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: contents.length,
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(contents[i].image!),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),
                      Text(
                        contents[i].title!,
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E3E5C),
                        ),
                      ),
                      Text(
                        contents[i].discription!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print(token.toString());
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => Obx(() => Scaffold(
                      extendBody: true, // Important for glass effect
                      body: Stack(
                        children: [
                          // Background (can be gradient, image, etc.)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFE0B2),
                                  Color(0xFFFFF3E0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),

                          // Page Content
                          pages[navController.currentIndex.value],
                        ],
                      ),
                      bottomNavigationBar: BottomNavBar(),
                    )),),
                  );
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                );
              },
              style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll(Size(200, 50)),
                elevation: const MaterialStatePropertyAll(0.0),
                backgroundColor: const MaterialStatePropertyAll(
                  Color(0xFFc52429),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Text(
                currentIndex == contents.length - 1 ? "Continue" : "Next",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Color(0xFFC2262D) : Colors.grey,
      ),
    );
  }
}
