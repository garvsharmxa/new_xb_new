import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xb/Constants/app_urls.dart';

class RegisterOtpService {
  static Future<http.Response?> sendEmailOtp(String email) async {
    final url = Uri.parse(AppUrls.sendRegisterOtp);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      return response;
    } catch (e) {
      print('AuthService error: $e');
      return null;
    }
  }
}
