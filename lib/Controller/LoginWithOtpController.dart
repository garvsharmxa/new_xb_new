import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xb/Nav/BottomNav.dart';
import '../Features/HomeScreen/HomeScreen.dart';
import '../Services/Auth/LoginWithOtpService.dart';

class LoginWithOtpController extends GetxController {
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  var isLoading = false.obs;

  // Store email as a variable instead of controller
  String email = '';

  // Method to set email from widget
  void setEmail(String widgetEmail) {
    email = widgetEmail;
  }

  Future<void> loginWithOtp() async {
    final password = passwordController.text.trim();
    final otp = otpController.text.trim();

    // Validation
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Email is required and must be valid");
      return;
    }

    if (password.isEmpty) {
      Get.snackbar("Password Required", "Please enter your password");
      return;
    }

    if (otp.isEmpty) {
      Get.snackbar("OTP Required", "Please enter the OTP");
      return;
    }

    if (otp.length != 6) {
      Get.snackbar("Invalid OTP", "OTP must be 6 digits");
      return;
    }

    isLoading.value = true;

    // Create the request body using the stored email
    final requestBody = {"email": email, "password": password, "otp": otp};

    try {
      final response = await LoginWithOtpService.loginWithOtp(requestBody);

      if (response != null) {
        if (response.statusCode == 200) {
          // Parse the response body
          final responseBody = await response.stream.bytesToString();
          final resBody = json.decode(responseBody);

          if (resBody['success'] == true) {
            // Success logic - navigate to home screen
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('accessToken', resBody['accessToken']);
            await prefs.setString('refreshToken', resBody['refreshToken']);

            print(responseBody);
            Get.snackbar(
              "Success",
              "Login successful!",
              snackPosition: SnackPosition.TOP,
              backgroundColor: const Color(0xffC2262D),
              colorText: Colors.white,
            );
            Get.offAll(() => BottomNavBar()); // Navigate to HomeScreen

            // Clear the text fields
            passwordController.clear();
            otpController.clear();
          } else {
            Get.snackbar(
              "Error",
              resBody['message'] ?? "Login failed",
              snackPosition: SnackPosition.TOP,
              backgroundColor: const Color(0xffC2262D),
              colorText: Colors.white,
            );
          }
        } else if (response.statusCode == 401) {
          Get.snackbar(
            "Error",
            "Invalid credentials or OTP",
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xffC2262D),
            colorText: Colors.white,
          );
        } else if (response.statusCode == 429) {
          Get.snackbar(
            "Error",
            "Too many attempts. Please try again later",
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xffC2262D),
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error",
            "Server error. Please try again",
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xffC2262D),
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to connect to server",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xffC2262D),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error in loginWithOtp: $e');
      Get.snackbar(
        "Error",
        "Network error. Please check your connection",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffC2262D),
        colorText: Colors.white,
      );
    } finally {
      // Always set loading to false when done
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    otpController.dispose();
    super.onClose();
  }
}