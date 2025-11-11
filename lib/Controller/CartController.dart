import 'package:get/get.dart';

import '../models/foodItems.dart';


class CartController extends GetxController {
  // Map<FoodItem, int> can't be used directly as FoodItem doesn't have ==/hashCode overridden.
  // We'll use FoodItem.name as a unique key for simplicity.
  final RxMap<String, int> _cartItems = <String, int>{}.obs;
  final RxMap<String, FoodItem> _foodItems = <String, FoodItem>{}.obs;

  void addToCart(FoodItem item) {
    _foodItems[item.name] = item;
    _cartItems.update(item.name, (count) => count + 1, ifAbsent: () => 1);
  }

  void removeFromCart(FoodItem item) {
    if (_cartItems.containsKey(item.name)) {
      if (_cartItems[item.name]! > 1) {
        _cartItems[item.name] = _cartItems[item.name]! - 1;
      } else {
        _cartItems.remove(item.name);
        _foodItems.remove(item.name);
      }
    }
  }

  int getItemCount(FoodItem item) => _cartItems[item.name] ?? 0;

  int get totalItems => _cartItems.values.fold(0, (sum, val) => sum + val);

  double get totalPrice => _cartItems.entries.fold(
    0.0,
    (sum, entry) =>
        sum + (((_foodItems[entry.key]?.price ?? 0.0) as double) * entry.value),
  );

  List<FoodItem> get cartItems =>
      _cartItems.entries.map((e) => _foodItems[e.key]!).toList();

  int getCountByName(String name) => _cartItems[name] ?? 0;

  void clearCart() {
    _cartItems.clear();
    _foodItems.clear();
  }
}
