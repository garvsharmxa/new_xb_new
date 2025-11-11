import 'package:get/get.dart';
import '../../models/Shop/ShopModel.dart'; // Import the Shop model

class FavoriteController extends GetxController {
  var favoriteShops = <Shop>[].obs;

  void addFavorite(Shop shop) {
    if (!isFavorite(shop)) {
      favoriteShops.add(shop);
    }
  }

  void removeFavorite(Shop shop) {
    favoriteShops.removeWhere((item) => item.id == shop.id);
  }

  bool isFavorite(Shop shop) {
    return favoriteShops.any((item) => item.id == shop.id);
  }
}