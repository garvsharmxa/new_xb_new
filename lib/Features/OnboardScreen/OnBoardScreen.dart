import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xb/Features/HomeScreen/HomeScreen.dart';
import 'package:xb/Nav/BottomNav.dart';
import 'package:xb/Widget/primaryButton.dart';
import '../../models/OnBoardContent.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  late PageController _controller;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: contents.length,
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                  _animationController.reset();
                  _animationController.forward();
                },
                itemBuilder: (_, i) => FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  contents[i].image!,
                                  height: 300,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFFC2262D), Color(0xFFE44E4E)],
                            ).createShader(bounds),
                            child: Text(
                              contents[i].title!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            contents[i].discription!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                text: currentIndex == contents.length - 1
                    ? "Get Started"
                    : "Next",
                onPressed: () {
                  if (currentIndex == contents.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => BottomNavBar()),
                    );
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: currentIndex == index ? 26 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? const Color(0xFFC2262D)
            : Colors.grey[300],
        boxShadow: currentIndex == index
            ? [
                BoxShadow(
                  color: const Color(0xFFC2262D).withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
    );
  }
}
