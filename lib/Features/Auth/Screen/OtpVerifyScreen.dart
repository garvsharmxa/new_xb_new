import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xb/Features/onboarding/GettingStartedScreen.dart';

import '../../../Widget/primaryButton.dart';
import '../../OnboardScreen/OnBoardScreen.dart';
import 'LoginScreen.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());

  final List<FocusNode> _focusNodes =
  List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _moveFocus(int index) {
    if (index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verification\nCode',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter the verification code that was provided to your email.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 30),

                // OTP Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                        maxLength: 1,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFC2262D),
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _moveFocus(index);
                          }
                        },
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // Resend Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "I don't receive a code! ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle resend code
                      },
                      child: const Text(
                        "Please resend",
                        style: TextStyle(
                          color: Color(0xFFC2262D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Verify Button
                PrimaryButton(
                  text: 'Verify',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBoardScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}