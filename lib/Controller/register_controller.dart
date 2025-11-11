import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xb/Features/OnboardScreen/OnBoardScreen.dart';
import '../Services/Auth/register_verify_service.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  var isLoading = false.obs;

  // Method to set the email from previous screen
  void setEmail(String email) {
    emailController.text = email;
  }

  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final otp = otpController.text.trim();

    if ([name, email, phone, password, otp].any((e) => e.isEmpty)) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    isLoading.value = true;

    final body = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "otp": otp,
    };

    final response = await RegisterVerifyService.verifyUser(body);

    isLoading.value = false;

    if (response != null) {
      final Map<String, dynamic> resBody = json.decode(response.body);

      if (response.statusCode == 201 && resBody['success'] == true) {
        Get.snackbar("Success", resBody['message'] ?? "Registration complete");
        Get.to(() => OnBoardScreen());
      } else {
        Get.snackbar("Error", resBody['message'] ?? "Something went wrong");
      }
    } else {
      Get.snackbar("Error", "Unable to connect to server");
    }
  }
}
