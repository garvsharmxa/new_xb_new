import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xb/Features/Auth/Screen/WelcomeScreen.dart';
import 'package:get/get.dart';
import 'package:xb/Features/PastOrder/PastOrdersScreen.dart';
import '../../Controller/LogoutController.dart';

class Drawers extends StatefulWidget {
  const Drawers({super.key});

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimation;
  final logoutController = Get.put(LogoutController());

  @override
  void initState() {
    super.initState();
    _iconAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 1.0,
      upperBound: 1.1,
    );
  }

  @override
  void dispose() {
    _iconAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: const Color(0xfff8f9fa),
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CurvedHeaderClipper(),
                  child: Container(
                    height: height * 0.21,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFC2262D), Color(0xffe8505b)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: width * 0.02,
                  top: height * 0.04,
                  child: Material(
                    elevation: 8,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      radius: width * 0.12,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: width * 0.11,
                        backgroundColor: Colors.grey.shade100,
                        backgroundImage: null,
                        child: Icon(
                          Icons.person,
                          color: const Color(0xffC2262D),
                          size: width * 0.12,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: width * .27,
                  top: height * 0.067,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Garv Sharma",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.007),
                      Text(
                        "garvsharmxa@gmail.com",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.03,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  _sectionHeader("Account", width),
                  drawerItem(
                    () {},
                    Icons.person_outline,
                    "Profile",
                    Colors.pinkAccent,
                    width,
                  ),
                  drawerItem(
                    () {},
                    Icons.location_on_outlined,
                    "Locations",
                    Colors.orangeAccent,
                    width,
                  ),
                  drawerItem(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PastOrdersScreen(),
                        ),
                      );
                    },
                    FontAwesomeIcons.bowlFood,
                    "Past Orders",
                    Colors.cyan,
                    width,
                  ),

                  _sectionHeader("Settings", width),
                  drawerItem(
                    () {},
                    Icons.settings_outlined,
                    "App Settings",
                    Colors.blueAccent,
                    width,
                  ),
                  drawerItem(
                    () {},
                    Icons.help_outline,
                    "Help & FAQs",
                    Colors.green,
                    width,
                  ),

                  Divider(
                    thickness: 1.2,
                    color: Colors.grey[200],
                    indent: width * 0.05,
                    endIndent: width * 0.05,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12,
              ),
              child: GestureDetector(
                onTapDown: (_) => _iconAnimation.forward(),
                onTapUp: (_) => _iconAnimation.reverse(),
                onTapCancel: () => _iconAnimation.reverse(),
                onTap: () {
                  logoutController.logoutUser();
                },
                child: AnimatedBuilder(
                  animation: _iconAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _iconAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [Color(0xFFC2262D), Color(0xffe8505b)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Colors.white, size: 22),
                        const SizedBox(width: 10),
                        Text(
                          "Log out",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                bottom: height * 0.02,
                top: height * 0.003,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(
                    FontAwesomeIcons.facebook,
                    const Color(0xff1877F2),
                    width,
                  ),
                  SizedBox(width: width * 0.055),
                  _socialIcon(
                    FontAwesomeIcons.instagram,
                    const Color(0xffE1306C),
                    width,
                  ),
                  SizedBox(width: width * 0.055),
                  _socialIcon(
                    FontAwesomeIcons.twitter,
                    const Color(0xff1DA1F2),
                    width,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(
    Function() press,
    IconData icon,
    String title,
    Color glowColor,
    double width,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.045, vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        elevation: 2,
        shadowColor: glowColor.withOpacity(0.2),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          splashColor: glowColor.withOpacity(0.1),
          onTap: press,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: glowColor.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(icon, color: glowColor, size: width * 0.055),
                ),
                SizedBox(width: width * 0.045),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.055, vertical: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: width * 0.04,
          color: Colors.grey[700],
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color, double width) {
    return Material(
      color: color.withOpacity(0.12),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(width * 0.025),
          child: FaIcon(icon, color: color, size: width * 0.07),
        ),
      ),
    );
  }
}

class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
