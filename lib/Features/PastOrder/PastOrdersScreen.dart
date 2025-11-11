import 'package:flutter/material.dart';

class PastOrdersScreen extends StatefulWidget {
  const PastOrdersScreen({super.key});

  @override
  State createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFFC2262D);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: Icon(null),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        title: Text(
          "Your Past Orders",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            shadows: [
              Shadow(
                color: themeColor.withOpacity(0.11),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Attractive graphic/animation
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.11),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: themeColor.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: themeColor,
                        size: 70,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      "No Past Orders Yet!",
                      style: TextStyle(
                        fontSize: 26,
                        color: themeColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Looks like you haven't placed any orders yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}