import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xb/Constants/app_urls.dart';

class LogoutService {
  static const String logoutUrl = AppUrls.logout;

  static Future<http.StreamedResponse?> logout(String accessToken) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      var request = http.Request('POST', Uri.parse(logoutUrl));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      return response;
    } catch (e) {
      print('Logout error: $e');
      return null;
    }
  }
}
