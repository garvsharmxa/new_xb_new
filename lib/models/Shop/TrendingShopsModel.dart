class TrendingShops {
  bool success;
  TrendingShopsLocation location;
  List<TrendingShop> trendingShops;
  int count;

  TrendingShops({
    required this.success,
    required this.location,
    required this.trendingShops,
    required this.count,
  });

  factory TrendingShops.fromJson(Map<String, dynamic> json) {
    return TrendingShops(
      success: json['success'] ?? false,
      location: TrendingShopsLocation.fromJson(json['location'] ?? {}),
      trendingShops: (json['trendingShops'] as List? ?? [])
          .map((shop) => TrendingShop.fromJson(shop))
          .toList(),
      count: json['count'] ?? 0,
    );
  }
}

class TrendingShopsLocation {
  String state;
  String city;

  TrendingShopsLocation({
    required this.state,
    required this.city,
  });

  factory TrendingShopsLocation.fromJson(Map<String, dynamic> json) {
    return TrendingShopsLocation(
      state: json['state'] ?? '',
      city: json['city'] ?? '',
    );
  }
}

class TrendingShop {
  String id;
  String name;
  String foodLicence;
  String image;
  String coverImage;
  String phone;
  String email;
  TrendingShopLocation location;
  List<String> cuisine;
  List<String> menuCategory;
  Rating rating;
  int cancelledOrders;
  bool online;
  bool takeawayAvailable;
  bool preOrderAvailable;
  int minOrderValue;
  int tax;
  int avgPreparationTime;
  String openTime;
  String closeTime;
  bool isActive;
  bool isVerified;
  bool isFeatured;
  int totalOrders;
  int totalRevenue;
  List<Owner> owner;
  List<String> specialties;
  List<String> tags;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int weeklyOrders;
  int estimatedPreparationTime;
  bool isCurrentlyOpen;
  String badge;

  TrendingShop({
    required this.id,
    required this.name,
    required this.foodLicence,
    required this.image,
    required this.coverImage,
    required this.phone,
    required this.email,
    required this.location,
    required this.cuisine,
    required this.menuCategory,
    required this.rating,
    required this.cancelledOrders,
    required this.online,
    required this.takeawayAvailable,
    required this.preOrderAvailable,
    required this.minOrderValue,
    required this.tax,
    required this.avgPreparationTime,
    required this.openTime,
    required this.closeTime,
    required this.isActive,
    required this.isVerified,
    required this.isFeatured,
    required this.totalOrders,
    required this.totalRevenue,
    required this.owner,
    required this.specialties,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.weeklyOrders,
    required this.estimatedPreparationTime,
    required this.isCurrentlyOpen,
    required this.badge,
  });

  factory TrendingShop.fromJson(Map<String, dynamic> json) {
    return TrendingShop(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      foodLicence: json['foodLicence'] ?? '',
      image: json['image'] ?? '',
      coverImage: json['coverImage'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      location: TrendingShopLocation.fromJson(json['location'] ?? {}),
      cuisine: List<String>.from(json['cuisine'] ?? []),
      menuCategory: List<String>.from(json['menuCategory'] ?? []),
      rating: Rating.fromJson(json['rating'] ?? {}),
      cancelledOrders: json['cancelledOrders'] ?? 0,
      online: json['online'] ?? false,
      takeawayAvailable: json['takeawayAvailable'] ?? false,
      preOrderAvailable: json['preOrderAvailable'] ?? false,
      minOrderValue: json['minOrderValue'] ?? 0,
      tax: json['tax'] ?? 0,
      avgPreparationTime: json['avgPreparationTime'] ?? 0,
      openTime: json['openTime'] ?? '',
      closeTime: json['closeTime'] ?? '',
      isActive: json['isActive'] ?? false,
      isVerified: json['isVerified'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      totalOrders: json['totalOrders'] ?? 0,
      totalRevenue: json['totalRevenue'] ?? 0,
      owner: (json['owner'] as List? ?? [])
          .map((o) => Owner.fromJson(o))
          .toList(),
      specialties: List<String>.from(json['specialties'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
      weeklyOrders: json['weeklyOrders'] ?? 0,
      estimatedPreparationTime: json['estimatedPreparationTime'] ?? 0,
      isCurrentlyOpen: json['isCurrentlyOpen'] ?? false,
      badge: json['badge'] ?? '',
    );
  }
}

class TrendingShopLocation {
  String state;
  String city;
  String area;
  String building;
  String landmark;
  String pincode;

  TrendingShopLocation({
    required this.state,
    required this.city,
    required this.area,
    required this.building,
    required this.landmark,
    required this.pincode,
  });

  factory TrendingShopLocation.fromJson(Map<String, dynamic> json) {
    return TrendingShopLocation(
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      area: json['area'] ?? '',
      building: json['building'] ?? '',
      landmark: json['landmark'] ?? '',
      pincode: json['pincode'] ?? '',
    );
  }
}

class Owner {
  String id;
  String name;
  String email;
  String password;
  String phone;
  Address address;
  String role;
  bool isDeliveryBoy;
  bool isRestaurantOwner;
  bool isAdmin;
  bool isActive;
  bool isVerified;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Owner({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.role,
    required this.isDeliveryBoy,
    required this.isRestaurantOwner,
    required this.isAdmin,
    required this.isActive,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
      role: json['role'] ?? '',
      isDeliveryBoy: json['isDeliveryBoy'] ?? false,
      isRestaurantOwner: json['isRestaurantOwner'] ?? false,
      isAdmin: json['isAdmin'] ?? false,
      isActive: json['isActive'] ?? false,
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
    );
  }
}

class Address {
  String country;

  Address({
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'] ?? '',
    );
  }
}

class Rating {
  int average;
  int count;

  Rating({
    required this.average,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average'] ?? 0,
      count: json['count'] ?? 0,
    );
  }
}
