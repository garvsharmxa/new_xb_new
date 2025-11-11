import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xb/Constants/app_urls.dart';
import 'package:xb/models/Shop/TrendingShopsModel.dart';

class TrendingShopService {
  Future<List<TrendingShop>> fetchShopsByCity(String city, String state) async {
    try {
      final response = await http.get(
        Uri.parse(
          AppUrls.buildUrlWithParams(
            AppUrls.getTrendingShops("Maharashtra", "Mumbai"),
            {"limit": 5},
          ),
        ),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        // Extract the list directly from 'trendingShops'
        final trendingList = decoded['trendingShops'] ?? [];

        return trendingList
            .map<TrendingShop>((json) => TrendingShop.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load shops: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching shops by city: $e');
      rethrow;
    }
  }
}