import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xb/Features/Auth/Screen/SignUpScreen.dart';
import '../../../Controller/LoginWithOtpController.dart';
import '../../../Widget/primaryButton.dart';

class LoginWithOtpScreen extends StatelessWidget {
  final String email; // Receive email here

  LoginWithOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Pass email to controller when creating it
    final LoginWithOtpController controller = Get.put(
      LoginWithOtpController(),
      tag: email, // Use email as tag to create unique controller instance
    );

    // Set the email in controller
    controller.setEmail(email);

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC2262D),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Login to your account',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 30),

                  // Display email (read-only)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.email_outlined, color: Color(0xFFC2262D)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              email,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  _buildInputField(
                    icon: Icons.lock_outline,
                    hintText: 'Your Password',
                    controller: controller.passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),

                  // OTP Field
                  _buildInputField(
                    icon: Icons.security_outlined,
                    hintText: 'Enter 6-digit OTP',
                    controller: controller.otpController,
                    inputType: TextInputType.number,
                    maxLength: 6,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),

                  const SizedBox(height: 24),

                  // Login Button
                  Obx(() => PrimaryButton(
                    text: controller.isLoading.value ? 'Logging in...' : 'Log In',
                    onPressed: controller.isLoading.value
                        ? () {} // Empty function instead of null
                        : () => controller.loginWithOtp(),
                  )),
                  const SizedBox(height: 30),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive OTP ? ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: Color(0xFFC2262D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
    TextInputType inputType = TextInputType.text,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    if (isPassword) {
      final RxBool obscure = true.obs;

      return Obx(() => Container(
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
          obscureText: obscure.value,
          keyboardType: inputType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            prefixIcon: Icon(icon, color: const Color(0xFFC2262D)),
            suffixIcon: IconButton(
              icon: Icon(
                obscure.value ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFFC2262D),
              ),
              onPressed: () => obscure.toggle(),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            counterText: "", // Hide character counter
          ),
          maxLength: maxLength,
        ),
      ));
    }

    // For non-password fields
    return Container(
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
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
          prefixIcon: Icon(icon, color: const Color(0xFFC2262D)),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          counterText: "", // Hide character counter
        ),
        maxLength: maxLength,
      ),
    );
  }
}