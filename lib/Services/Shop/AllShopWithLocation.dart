import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:xb/Constants/app_urls.dart';
import 'package:xb/models/Shop/ShopModel.dart';

class AllShopWithLocationService extends GetxService {
  Future<List<Shop>> fetchShopsByCity(String city) async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrls.getAllShops}?city=$city'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        // Handle different response structures
        List<dynamic> shopsJson;
        if (decoded is List) {
          shopsJson = decoded;
        } else if (decoded is Map && decoded.containsKey('shops')) {
          shopsJson = decoded['shops'] is List ? decoded['shops'] : [];
        } else if (decoded is Map && decoded.containsKey('data')) {
          shopsJson = decoded['data'] is List ? decoded['data'] : [];
        } else {
          shopsJson = [];
        }

        // Convert to Shop objects
        return shopsJson.map((json) => Shop.fromJson(json)).toList();

      } else {
        throw Exception('Failed to load shops: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching shops by city: $e');
      rethrow;
    }
  }
}
