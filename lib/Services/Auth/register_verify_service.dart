// lib/Services/register_verify_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/app_urls.dart';

class RegisterVerifyService {
  static Future<http.Response?> verifyUser(Map<String, dynamic> body) async {
    try {
      final url = Uri.parse(AppUrls.verifyRegistration);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      print('RegisterVerifyService error: $e');
      return null;
    }
  }
}
