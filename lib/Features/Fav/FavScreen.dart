import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xb/Controller/FavoriteController.dart';
import 'package:xb/Features/HomeScreen/Widgets/shopList.dart';
import '../../../models/ShopModel.dart';
import '../../../models/Shop/ShopModel.dart' as shop_models;
import '../ShopScreen/Screen/ShopScreen.dart';
import 'package:xb/Features/HomeScreen/Widgets/RestaurantListScreen.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFFC2262D);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: Icon(null),
        backgroundColor: Colors.grey.shade50,
        title: Text(
          "Your Favorite Shops",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            shadows: [
              Shadow(
                color: themeColor.withOpacity(0.11),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF9F9FB),
        child: Obx(() {
          final favorites = favoriteController.favoriteShops;
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Attractive icon/graphic
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(0.11),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: themeColor.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: themeColor,
                      size: 70,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    "No Favorite Shops Yet!",
                    style: TextStyle(
                      fontSize: 26,
                      color: themeColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Start exploring and add your favorite shops.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            itemCount: favorites.length,
            separatorBuilder: (context, index) => const SizedBox(height: 0),
            itemBuilder: (context, index) {
              final shop = favorites[index];
              return ShopList(
                shopModel: ShopModel(
                  avgTime: shop.avgPreparationTime,
                  imageUrl: shop.image ?? shop.coverImage ?? "",
                  restaurantName: shop.name,
                  address: shop.location.fullAddress,
                  stamps: shop.totalOrders.toString(),
                  backgroundColor: Colors.white,
                ),
                isFavorite: true,
                onTap: () {
                  // Map Shop to RestaurantData for ShopScreen
                  final restaurantData = RestaurantData(
                    prepTime: shop.avgPreparationTime,
                    isFavorite: true,
                    name: shop.name,
                    category: shop.cuisine.isNotEmpty
                        ? shop.cuisine.first
                        : "N/A",
                    rating: shop.rating.average,
                    deliveryTime:
                        "${shop.estimatedPreparationTime > 0 ? shop.estimatedPreparationTime : shop.avgPreparationTime} mins",
                    imageUrl: shop.image ?? shop.coverImage ?? "",
                    backgroundColor: Colors.white,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShopScreen(restaurant: restaurantData),
                    ),
                  );
                },
                onFavoriteToggle: () {
                  favoriteController.removeFavorite(shop);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
