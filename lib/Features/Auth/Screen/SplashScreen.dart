import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds using GetX
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffC2262D), Color(0xffA01E24)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // White curved container
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(
                          image: AssetImage("assets/XB logo.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Logo Text
                    Container(
                      height: 100,
                      width: 250,
                      child: const Image(
                        image: AssetImage("assets/XB in text.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Tagline
              Column(
                children: [
                  Text(
                    "Deliciousness Delivered Fast",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your favorite meals, just a tap away",
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Simple loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}