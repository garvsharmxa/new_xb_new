import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Cart/CartScreen.dart';
import '../../../Controller/CartController.dart';
import '../../../models/foodItems.dart';

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodCard({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {}, // Optional: add detail navigation
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food Image with Hero effect
              Hero(
                tag: foodItem.imageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    foodItem.imageUrl,
                    width: 100,
                    height: 95,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 90,
                      height: 95,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported, size: 32),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Food Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name & Best Seller Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            foodItem.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.1,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        if (foodItem.Recommended) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Recommended',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Category
                    Row(
                      children: [
                        Text(
                          foodItem.category,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xffc2262d),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Price & Counter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${foodItem.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Obx(() {
                          final itemCount = cartController.getItemCount(
                            foodItem,
                          );

                          return itemCount == 0
                              ? GestureDetector(
                                  onTap: () {
                                    cartController.addToCart(foodItem);
                                    // Navigate to Cart Screen on first add
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffc2262d),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Text(
                                      'Add',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => cartController
                                          .removeFromCart(foodItem),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 150,
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Color(0xffc2262d),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Text(
                                        '$itemCount',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          cartController.addToCart(foodItem),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 150,
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Color(0xffc2262d),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
