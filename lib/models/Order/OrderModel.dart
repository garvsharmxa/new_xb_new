class OrderModel {
  final String id;
  final String userId;
  final String shopId;
  final String shopName;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final double totalAmount;
  final String deliveryAddress;
  final OrderStatus status;
  final String paymentMethod;
  final String? paymentId;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;
  final String? specialInstructions;

  OrderModel({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.shopName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.status,
    required this.paymentMethod,
    this.paymentId,
    required this.createdAt,
    this.estimatedDeliveryTime,
    this.specialInstructions,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? json['_id'] ?? '',
      userId: json['userId'] ?? '',
      shopId: json['shopId'] ?? '',
      shopName: json['shopName'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromJson(item))
              .toList() ??
          [],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      deliveryAddress: json['deliveryAddress'] ?? '',
      status: _parseOrderStatus(json['status']),
      paymentMethod: json['paymentMethod'] ?? 'cash',
      paymentId: json['paymentId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? DateTime.parse(json['estimatedDeliveryTime'])
          : null,
      specialInstructions: json['specialInstructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'shopId': shopId,
      'shopName': shopName,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'tax': tax,
      'discount': discount,
      'totalAmount': totalAmount,
      'deliveryAddress': deliveryAddress,
      'status': status.value,
      'paymentMethod': paymentMethod,
      'paymentId': paymentId,
      'createdAt': createdAt.toIso8601String(),
      'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
      'specialInstructions': specialInstructions,
    };
  }

  static OrderStatus _parseOrderStatus(dynamic status) {
    if (status == null) return OrderStatus.placed;
    String statusStr = status.toString().toLowerCase();
    switch (statusStr) {
      case 'placed':
        return OrderStatus.placed;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'preparing':
        return OrderStatus.preparing;
      case 'ready':
        return OrderStatus.ready;
      case 'completed':
        return OrderStatus.completed;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.placed;
    }
  }
}

class OrderItem {
  final String foodId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;
  final double totalPrice;

  OrderItem({
    required this.foodId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      foodId: json['foodId'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      quantity: json['quantity'] ?? 1,
      price: (json['price'] ?? 0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'name': name,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,
    };
  }
}

enum OrderStatus {
  placed,
  confirmed,
  preparing,
  ready,
  completed,
  cancelled;

  String get value {
    switch (this) {
      case OrderStatus.placed:
        return 'placed';
      case OrderStatus.confirmed:
        return 'confirmed';
      case OrderStatus.preparing:
        return 'preparing';
      case OrderStatus.ready:
        return 'ready';
      case OrderStatus.completed:
        return 'completed';
      case OrderStatus.cancelled:
        return 'cancelled';
    }
  }

  String get displayName {
    switch (this) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case OrderStatus.placed:
        return 'Your order has been placed successfully';
      case OrderStatus.confirmed:
        return 'Shop has confirmed your order';
      case OrderStatus.preparing:
        return 'Your delicious food is being prepared';
      case OrderStatus.ready:
        return 'Your order is ready for pickup';
      case OrderStatus.completed:
        return 'Order completed. Thank you!';
      case OrderStatus.cancelled:
        return 'This order has been cancelled';
    }
  }
}
