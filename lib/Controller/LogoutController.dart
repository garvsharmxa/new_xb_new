import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xb/Services/Auth/LogoutService.dart';
import 'package:flutter/material.dart';
import 'package:xb/Features/Auth/Screen/WelcomeScreen.dart';

class LogoutController extends GetxController {
  var isLoggingOut = false.obs;

  Future<void> logoutUser() async {
    isLoggingOut.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      Get.snackbar("Error", "No access token found");
      isLoggingOut.value = false;
      return;
    }

    final response = await LogoutService.logout(accessToken);

    if (response != null && response.statusCode == 200) {
      // Clear tokens
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');

      // Optional: Clear other saved user info if any
      await prefs.clear();

      Get.snackbar(
        "Logged Out",
        "You have been successfully logged out",
        backgroundColor: const Color(0xffC2262D),
        colorText: Colors.white,
      );

      // Navigate to WelcomeScreen
      Get.offAll(() => const WelcomeScreen());
    } else {
      Get.snackbar(
        "Logout Failed",
        "Something went wrong while logging out",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }

    isLoggingOut.value = false;
  }
}
