import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xb/Features/Auth/Screen/RegisterScreen.dart';
import 'package:xb/Features/Auth/Screen/SignUpScreen.dart';

import '../../../Controller/login_otp_controller.dart';
import '../../../Widget/primaryButton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFC2262D),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Login to your account',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  _buildInputField(
                    icon: Icons.email_outlined,
                    hintText: 'Your Email',
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 16),

                  // Login Button - Fixed the null issue
                  PrimaryButton(
                    text: controller.isLoading.value ? 'Sending OTP...' : 'Log In',
                    onPressed: controller.isLoading.value
                        ? () {} // Empty function instead of null
                        : () => controller.sendOtp(),
                  ),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      const Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      const Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => SignUpScreen()),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFFC2262D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    final RxBool obscure = isPassword.obs;

    final container = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscure.value : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          prefixIcon: Icon(icon, color: const Color(0xFFC2262D)),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              obscure.value ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFFC2262D),
            ),
            onPressed: () => obscure.toggle(),
          )
              : null,
          hintText: hintText,
        ),
      ),
    );

    // Only wrap with Obx if we have password field that needs reactivity
    return isPassword ? Obx(() => container) : container;
  }
}