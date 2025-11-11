import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xb/Constants/app_urls.dart';

class LoginWithOtpService {
  static const String baseUrl = AppUrls.verifyLogin;

  static Future<http.StreamedResponse?> loginWithOtp(Map<String, String> requestBody) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var request = http.Request('POST', Uri.parse(baseUrl));
      request.body = json.encode(requestBody);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      return response;
    } catch (e) {
      print('Error in loginWithOtp: $e');
      return null;
    }
  }
}
