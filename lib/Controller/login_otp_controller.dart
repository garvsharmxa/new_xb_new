// lib/Controller/login_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Features/Auth/Screen/LoginWithOtpScreen.dart';
import '../Services/Auth/login_otp_service.dart';
import '../Features/HomeScreen/HomeScreen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  var isLoading = false.obs;

  Future<void> sendOtp() async {
    final email = emailController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address");
      return;
    }

    isLoading.value = true;

    final response = await LoginOtpService.sendLoginOtp(email);

    isLoading.value = false;

    if (response != null) {
      final resBody = json.decode(response.body);
      if (response.statusCode == 200 && resBody['success'] == true) {
        print(response.body);
        Get.snackbar(
          "Success",
          resBody['message'] ?? "OTP Sent",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xffC2262D),
          colorText: Colors.white,
        );
        Get.to(() => LoginWithOtpScreen(email: emailController.text)); // Replace with OTP screen if needed
      } else {
        print(response.body);
        Get.snackbar(
          "Error",
          resBody['message'] ?? "Failed to send OTP",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xffC2262D),
          colorText: Colors.white,
        );
      }
    } else {
      print("Error: Unable to connect to server");
      Get.snackbar(
        "Error",
        "Something went wrong. Try again later.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffC2262D),
        colorText: Colors.white,
      );
    }
  }
}
