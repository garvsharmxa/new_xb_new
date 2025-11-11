import 'package:flutter/material.dart';

class FoodAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;

  const FoodAppBar({Key? key, this.notificationCount = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.restaurant_menu_rounded,
              color: Color(0xFFC2262D),
              size: 35,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey Garv!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                shadows: [
                  Shadow(
                    color: const Color(0xFFC2262D).withOpacity(0.1),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            Text(
              "What's cooking today?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Color(0xFFC2262D),
                        size: 35,
                      ),
                    ),
                  ),
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF4757), Color(0xFFFF3838)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF4757).withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        notificationCount > 99 ? '99+' : '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
