import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/register_otp_controller.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final RegisterOtpController authController = Get.put(RegisterOtpController());

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
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),

                  // Email Input
                  _buildInputField(
                    controller: authController.emailController,
                    icon: Icons.email_outlined,
                    hintText: 'Enter your Email',
                  ),
                  const SizedBox(height: 30),

                  // Send OTP Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authController.isLoading.value
                          ? null
                          : authController.sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC2262D),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: authController.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Send OTP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Divider(thickness: 1),
                  const SizedBox(height: 16),

                  // Sign In Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => LoginScreen()),
                        child: const Text(
                          "Sign In",
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
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          prefixIcon: Icon(icon, color: const Color(0xFFC2262D)),
          hintText: hintText,
        ),
      ),
    );
  }
}
