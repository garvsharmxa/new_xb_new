import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xb/Features/Auth/Screen/LoginScreen.dart';
import 'package:xb/Features/Auth/Screen/RegisterScreen.dart';
import 'package:xb/Features/Auth/Screen/SignUpScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/welcomeImage.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Glassmorphism Overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.1), // Slight dark overlay
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
              child: Container(
                color: Colors.black.withOpacity(0.05), // Softness layer
              ),
            ),
          ),

          // Main Content
          Column(
            children: [
              Container(height: MediaQuery.of(context).size.height / 2.7),
              const SizedBox(height: 100),
              Text(
                'Welcome to',
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 120,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const Image(
                    image: AssetImage("assets/Pi7_XB in text.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.white.withOpacity(0.5),
                        thickness: 1,
                      ),
                    ),
                  ),
                  Text(
                    "Start in with",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.white.withOpacity(0.5),
                        thickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Container(
                  width: double.infinity,
                  height: 65,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.25),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(35),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withOpacity(0.15),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Start with Email',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.4),
                                          offset: const Offset(1, 1),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account?  ',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                            shadows: [
                              Shadow(
                                color: Colors.white.withOpacity(0.6),
                                blurRadius: 10,
                              ),
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
