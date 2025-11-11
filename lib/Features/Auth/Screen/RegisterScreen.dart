import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/register_controller.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  final String? email; // Accept email parameter

  RegisterScreen({super.key, this.email});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    // Set the email in the controller if provided
    if (email != null && email!.isNotEmpty) {
      controller.setEmail(email!);
    }

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
                    'Register',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),

                  _buildInputField(
                    controller.nameController,
                    Icons.person_outline,
                    'Full Name',
                  ),
                  const SizedBox(height: 20),

                  // Email field - make it read-only if email was passed
                  _buildInputField(
                    controller.emailController,
                    Icons.email_outlined,
                    'Email',
                    isReadOnly: email != null && email!.isNotEmpty,
                  ),
                  const SizedBox(height: 20),

                  _buildInputField(
                    controller.phoneController,
                    Icons.phone_outlined,
                    'Your Number',
                    isNumber: true,
                  ),
                  const SizedBox(height: 20),

                  _buildInputField(
                    controller.passwordController,
                    Icons.lock_outline,
                    'Your Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),

                  _buildInputField(
                    controller.otpController,
                    Icons.password,
                    'Your OTP',
                    isNumber: true,
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC2262D),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Divider(thickness: 1),
                  const SizedBox(height: 16),

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

  Widget _buildInputField(
      TextEditingController controller,
      IconData icon,
      String hintText, {
        bool isPassword = false,
        bool isNumber = false,
        bool isReadOnly = false,
      }) {
    // Create a StatefulWidget for password visibility toggle
    if (isPassword) {
      return _PasswordField(
        controller: controller,
        icon: icon,
        hintText: hintText,
      );
    }

    // For non-password fields
    return Container(
      decoration: BoxDecoration(
        color: isReadOnly ? const Color(0xffEEEEEE) : const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isReadOnly ? Colors.grey.shade400 : Colors.grey.shade300,
        ),
      ),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: TextStyle(
          color: isReadOnly ? Colors.grey.shade600 : Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          prefixIcon: Icon(
            icon,
            color: isReadOnly ? Colors.grey.shade500 : const Color(0xFFC2262D),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: isReadOnly ? Colors.grey.shade500 : null,
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;

  const _PasswordField({
    required this.controller,
    required this.icon,
    required this.hintText,
  });

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          prefixIcon: Icon(widget.icon, color: const Color(0xFFC2262D)),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFFC2262D),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}