class Shop {
  final String id;
  final String name;
  final String foodLicence;
  final String? image;
  final String? coverImage;
  final String phone;
  final String email;
  final Location location;
  final List<String> cuisine;
  final List<String> menuCategory;
  final Rating rating;
  final int cancelledOrders;
  final bool online;
  final bool takeawayAvailable;
  final bool preOrderAvailable;
  final double minOrderValue;
  final double tax;
  final int avgPreparationTime;
  final String openTime;
  final String closeTime;
  final bool isActive;
  final bool isVerified;
  final bool isFeatured;
  final int totalOrders;
  final double totalRevenue;
  final Owner owner;
  final List<String> specialties;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final bool isCurrentlyOpen;
  final int menuItemsCount;
  final int recentReviewsCount;
  final int estimatedPreparationTime;

  Shop({
    required this.id,
    required this.name,
    required this.foodLicence,
    this.image,
    this.coverImage,
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
    required this.version,
    required this.isCurrentlyOpen,
    required this.menuItemsCount,
    required this.recentReviewsCount,
    required this.estimatedPreparationTime,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      foodLicence: json['foodLicence'] ?? '',
      image: json['image'],
      coverImage: json['coverImage'],
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      cuisine: List<String>.from(json['cuisine'] ?? []),
      menuCategory: List<String>.from(json['menuCategory'] ?? []),
      rating: Rating.fromJson(json['rating'] ?? {}),
      cancelledOrders: json['cancelledOrders'] ?? 0,
      online: json['online'] ?? false,
      takeawayAvailable: json['takeawayAvailable'] ?? false,
      preOrderAvailable: json['preOrderAvailable'] ?? false,
      minOrderValue: (json['minOrderValue'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      avgPreparationTime: json['avgPreparationTime'] ?? 0,
      openTime: json['openTime'] ?? '',
      closeTime: json['closeTime'] ?? '',
      isActive: json['isActive'] ?? false,
      isVerified: json['isVerified'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      totalOrders: json['totalOrders'] ?? 0,
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      owner: Owner.fromJson(json['owner'] ?? {}),
      specialties: List<String>.from(json['specialties'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      version: json['__v'] ?? 0,
      isCurrentlyOpen: json['isCurrentlyOpen'] ?? false,
      menuItemsCount: json['menuItemsCount'] ?? 0,
      recentReviewsCount: json['recentReviewsCount'] ?? 0,
      estimatedPreparationTime: json['estimatedPreparationTime'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'foodLicence': foodLicence,
      'image': image,
      'coverImage': coverImage,
      'phone': phone,
      'email': email,
      'location': location.toJson(),
      'cuisine': cuisine,
      'menuCategory': menuCategory,
      'rating': rating.toJson(),
      'cancelledOrders': cancelledOrders,
      'online': online,
      'takeawayAvailable': takeawayAvailable,
      'preOrderAvailable': preOrderAvailable,
      'minOrderValue': minOrderValue,
      'tax': tax,
      'avgPreparationTime': avgPreparationTime,
      'openTime': openTime,
      'closeTime': closeTime,
      'isActive': isActive,
      'isVerified': isVerified,
      'isFeatured': isFeatured,
      'totalOrders': totalOrders,
      'totalRevenue': totalRevenue,
      'owner': owner.toJson(),
      'specialties': specialties,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
      'isCurrentlyOpen': isCurrentlyOpen,
      'menuItemsCount': menuItemsCount,
      'recentReviewsCount': recentReviewsCount,
      'estimatedPreparationTime': estimatedPreparationTime,
    };
  }

  Shop copyWith({
    String? id,
    String? name,
    String? foodLicence,
    String? image,
    String? coverImage,
    String? phone,
    String? email,
    Location? location,
    List<String>? cuisine,
    List<String>? menuCategory,
    Rating? rating,
    int? cancelledOrders,
    bool? online,
    bool? takeawayAvailable,
    bool? preOrderAvailable,
    double? minOrderValue,
    double? tax,
    int? avgPreparationTime,
    String? openTime,
    String? closeTime,
    bool? isActive,
    bool? isVerified,
    bool? isFeatured,
    int? totalOrders,
    double? totalRevenue,
    Owner? owner,
    List<String>? specialties,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    bool? isCurrentlyOpen,
    int? menuItemsCount,
    int? recentReviewsCount,
    int? estimatedPreparationTime,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      foodLicence: foodLicence ?? this.foodLicence,
      image: image ?? this.image,
      coverImage: coverImage ?? this.coverImage,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      location: location ?? this.location,
      cuisine: cuisine ?? this.cuisine,
      menuCategory: menuCategory ?? this.menuCategory,
      rating: rating ?? this.rating,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      online: online ?? this.online,
      takeawayAvailable: takeawayAvailable ?? this.takeawayAvailable,
      preOrderAvailable: preOrderAvailable ?? this.preOrderAvailable,
      minOrderValue: minOrderValue ?? this.minOrderValue,
      tax: tax ?? this.tax,
      avgPreparationTime: avgPreparationTime ?? this.avgPreparationTime,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      isFeatured: isFeatured ?? this.isFeatured,
      totalOrders: totalOrders ?? this.totalOrders,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      owner: owner ?? this.owner,
      specialties: specialties ?? this.specialties,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      isCurrentlyOpen: isCurrentlyOpen ?? this.isCurrentlyOpen,
      menuItemsCount: menuItemsCount ?? this.menuItemsCount,
      recentReviewsCount: recentReviewsCount ?? this.recentReviewsCount,
      estimatedPreparationTime: estimatedPreparationTime ?? this.estimatedPreparationTime,
    );
  }

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, phone: $phone, email: $email, isCurrentlyOpen: $isCurrentlyOpen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Shop && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Location {
  final String state;
  final String city;
  final String area;
  final String building;
  final String landmark;
  final String pincode;

  Location({
    required this.state,
    required this.city,
    required this.area,
    required this.building,
    required this.landmark,
    required this.pincode,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      area: json['area'] ?? '',
      building: json['building'] ?? '',
      landmark: json['landmark'] ?? '',
      pincode: json['pincode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'city': city,
      'area': area,
      'building': building,
      'landmark': landmark,
      'pincode': pincode,
    };
  }

  Location copyWith({
    String? state,
    String? city,
    String? area,
    String? building,
    String? landmark,
    String? pincode,
  }) {
    return Location(
      state: state ?? this.state,
      city: city ?? this.city,
      area: area ?? this.area,
      building: building ?? this.building,
      landmark: landmark ?? this.landmark,
      pincode: pincode ?? this.pincode,
    );
  }

  String get fullAddress => '$building, $area, $city, $state - $pincode';

  @override
  String toString() {
    return 'Location(city: $city, area: $area, pincode: $pincode)';
  }
}

class Rating {
  final double average;
  final int count;

  Rating({
    required this.average,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: (json['average'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average': average,
      'count': count,
    };
  }

  Rating copyWith({
    double? average,
    int? count,
  }) {
    return Rating(
      average: average ?? this.average,
      count: count ?? this.count,
    );
  }

  @override
  String toString() {
    return 'Rating(average: $average, count: $count)';
  }
}

class Owner {
  final String id;
  final String name;
  final String email;
  final String phone;

  Owner({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  Owner copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return Owner(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  String toString() {
    return 'Owner(id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Owner && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}