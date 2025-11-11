import 'dart:ui';

class ShopModel {
  final String imageUrl;
  final String restaurantName;
  final String address;
  final int avgTime;
  final String stamps;
  final Color backgroundColor;

  ShopModel( {
    required this.avgTime,
    required this.imageUrl,
    required this.restaurantName,
    required this.address,
    required this.stamps,
    required this.backgroundColor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ShopModel &&
              runtimeType == other.runtimeType &&
              restaurantName == other.restaurantName;

  @override
  int get hashCode => restaurantName.hashCode;
}
