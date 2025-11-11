import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/app_urls.dart';

class LoginOtpService {
  static Future<http.Response?> sendLoginOtp(String email) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrls.sendLoginOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return response;
    } catch (e) {
      print('LoginOtpService error: $e');
      return null;
    }
  }
}
