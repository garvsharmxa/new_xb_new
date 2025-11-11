import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../SearchFoodScreen.dart';

class FoodItem {
  final String name;
  final String image;
  final String description;
  final double rating;
  final String price;
  final Color accentColor;

  FoodItem({
    required this.name,
    required this.image,
    required this.description,
    required this.rating,
    required this.price,
    required this.accentColor,
  });
}

class FoodListWidget extends StatefulWidget {
  @override
  _FoodListWidgetState createState() => _FoodListWidgetState();
}

class _FoodListWidgetState extends State<FoodListWidget>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _listAnimationController;
  late Animation<double> _headerAnimation;
  late Animation<double> _listAnimation;

  final List<FoodItem> foodItems = [
    FoodItem(
      name: 'Chole Bhature',
      image:
          'https://cdn.zeptonow.com/production///tr:w-600,ar-100-100,pr-true,f-auto,q-80/web/recipes/chola-bhatura.png',
      description: 'Spicy chickpea curry with fluffy bread',
      rating: 4.8,
      price: '₹120',
      accentColor: const Color(0xFFFF6B6B),
    ),
    FoodItem(
      name: 'Paneer Butter Masala',
      image:
          'https://cdn.zeptonow.com/production///tr:w-600,ar-100-100,pr-true,f-auto,q-80/web/recipes/paneer-butter-masala.png',
      description: 'Creamy cottage cheese in rich tomato gravy',
      rating: 4.9,
      price: '₹180',
      accentColor: const Color(0xFF4ECDC4),
    ),
    FoodItem(
      name: 'Veg Biryani',
      image:
          'https://i.ytimg.com/vi/Do7ZdUodDdw/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAEQctXy1aD1723HT7omylxjn4tMQ',
      description: 'Aromatic basmati rice with mixed vegetables',
      rating: 4.7,
      price: '₹150',
      accentColor: const Color(0xFFFFE66D),
    ),
    FoodItem(
      name: 'Dal Makhani',
      image:
          'https://img.taste.com.au/cjPf9_uA/taste/2025/03/dal-makhani-indian-butter-lentils-2-208408-1.jpg',
      description: 'Rich and creamy black lentil curry',
      rating: 4.6,
      price: '₹140',
      accentColor: const Color(0xFF95E1D3),
    ),
    FoodItem(
      name: 'Masala Dosa',
      image:
          'https://www.mydelicious-recipes.com/home/images/120_1080_1080/mydelicious-recipes-masala-dosa-with-batter',
      description: 'Crispy crepe with spiced potato filling',
      rating: 4.8,
      price: '₹80',
      accentColor: const Color(0xFFA8E6CF),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _headerAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    _listAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _listAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _headerAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _listAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _listAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: _headerAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _headerAnimation.value)),
                child: Opacity(
                  opacity: _headerAnimation.value.clamp(0.0, 1.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Eat what makes you ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2D3436),
                                  letterSpacing: -1.0,
                                  height: 1.2,
                                ),
                              ),
                              TextSpan(
                                text: "happy",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFC2262D),
                                  letterSpacing: -1.0,
                                  height: 1.2,
                                ),
                              ),
                              TextSpan(
                                text: ".. ✨",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2D3436),
                                  letterSpacing: -1.0,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // Enhanced Horizontal Food Categories
          AnimatedBuilder(
            animation: _listAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _listAnimation.value,
                child: Opacity(
                  opacity: _listAnimation.value.clamp(0.0, 1.0),
                  child: SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: foodItems.length,
                      itemBuilder: (context, index) {
                        return TweenAnimationBuilder(
                          duration: Duration(milliseconds: 800 + (index * 100)),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, double value, child) {
                            return Transform.translate(
                              offset: Offset(0, 30 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: _buildFoodCard(foodItems[index], index),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(FoodItem item, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SearchFoodScreen(name: item.name, imageUrl: item.image),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            children: [
              // Enhanced Image Container
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      item.accentColor.withOpacity(0.2),
                      item.accentColor.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: item.accentColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: item.accentColor.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: item.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Enhanced Text Content
              Container(
                width: 100,
                child: Column(
                  children: [
                    Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF2D3436),
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
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
