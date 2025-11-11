// lib/Controller/register_otp_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xb/Services/Auth/register_otp_service.dart';
import '../Features/Auth/Screen/RegisterScreen.dart';

class RegisterOtpController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();

  void sendOtp() async {
    final email = emailController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffC2262D),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await RegisterOtpService.sendEmailOtp(email);
      isLoading.value = false;

      if (response != null) {
        final isJson =
            response.headers['content-type']?.contains('application/json') ??
                false;

        if (isJson) {
          final Map<String, dynamic> resBody = json.decode(response.body);

          if (response.statusCode == 200 && resBody['success'] == true) {
            Get.snackbar(
              "Success",
              resBody['message'] ?? 'OTP sent',
              snackPosition: SnackPosition.TOP,
            );
            // Pass the email to RegisterScreen
            Get.to(() => RegisterScreen(email: email));
          } else {
            Get.snackbar(
              "Error",
              resBody['message'] ?? "Unknown error occurred",
              snackPosition: SnackPosition.TOP,
              backgroundColor: const Color(0xffC2262D),
              colorText: Colors.white,
            );
          }
        } else {
          Get.snackbar(
            "Error",
            "Unexpected server response",
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "No response from server",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Exception",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xffC2262D),
        colorText: Colors.white,
      );
    }
  }
}