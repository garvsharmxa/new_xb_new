import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantData {
  final int prepTime;
  final String name;
  final String category;
  final double rating;
  final String deliveryTime;
  final String imageUrl;
  final bool isFavorite;
  final Color? backgroundColor;
  final String? address;
  final String? distance;
  final int? reviewCount;

  RestaurantData({
    required this.isFavorite,
    required this.name,
    required this.category,
    required this.rating,
    required this.deliveryTime,
    required this.imageUrl,
    this.backgroundColor,
    required this.prepTime,
    this.address,
    this.distance,
    this.reviewCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          category == other.category &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => name.hashCode ^ category.hashCode ^ imageUrl.hashCode;
}

class RestaurantHorizontalWidget extends StatefulWidget {
  final List<RestaurantData> restaurants;
  final bool Function(RestaurantData restaurant)? isFavorite;
  final Function(RestaurantData)? onRestaurantTap;
  final Function(RestaurantData)? onFavoriteToggle;

  const RestaurantHorizontalWidget({
    Key? key,
    required this.restaurants,
    this.onRestaurantTap,
    this.onFavoriteToggle,
    this.isFavorite,
  }) : super(key: key);

  @override
  State<RestaurantHorizontalWidget> createState() =>
      _RestaurantHorizontalWidgetState();
}

class _RestaurantHorizontalWidgetState
    extends State<RestaurantHorizontalWidget> {
  List<bool> favoriteStates = [];

  @override
  void initState() {
    super.initState();
    _initializeFavoriteStates();
  }

  @override
  void didUpdateWidget(RestaurantHorizontalWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.restaurants != widget.restaurants) {
      _initializeFavoriteStates();
    }
  }

  void _initializeFavoriteStates() {
    favoriteStates = widget.restaurants.map((restaurant) {
      if (widget.isFavorite != null) {
        return widget.isFavorite!(restaurant);
      }
      return restaurant.isFavorite;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.restaurants.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No restaurants available',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search criteria',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 200, // Fixed height for horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.restaurants.length,
        itemBuilder: (context, index) {
          return Container(

            width: 140, // Fixed width for each card
            margin: const EdgeInsets.only(right: 8),
            child: RestaurantCard(
              key: ValueKey(
                'restaurant_${widget.restaurants[index].name}_$index',
              ),
              restaurant: widget.restaurants[index],
              isFavorite: favoriteStates[index],
              onTap: () =>
                  widget.onRestaurantTap?.call(widget.restaurants[index]),
              onFavoriteToggle: () {
                setState(() {
                  favoriteStates[index] = !favoriteStates[index];
                });
                widget.onFavoriteToggle?.call(widget.restaurants[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final RestaurantData restaurant;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
    required this.isFavorite,
    this.onTap,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final deliveryMinutes = int.parse(
        restaurant.deliveryTime.replaceAll(RegExp(r'[^0-9]'), '')
    );

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: restaurant.backgroundColor ?? Colors.grey.shade200,
                  ),
                  child: Stack(
                    children: [
                      // Background image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: restaurant.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant,
                                  size: 32,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Image not available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: Colors.grey.shade500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                            stops: const [0.6, 1.0],
                          ),
                        ),
                      ),
                      // Category badge (if needed)
                    ],
                  ),
                ),
              ),
              // Restaurant info section
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          if (restaurant.address != null)
                            Text(
                              restaurant.address!,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Rating
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _getRatingColor(restaurant.rating),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  restaurant.rating.toString(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Delivery time
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                "${deliveryMinutes + 15}",  // Adds 15 to the numeric value
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      // Distance (if available)
                      if (restaurant.distance != null)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 12,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                restaurant.distance!,
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade500,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) {
      return Colors.green.shade600;
    } else if (rating >= 4.0) {
      return Colors.green.shade500;
    } else if (rating >= 3.5) {
      return Colors.orange.shade600;
    } else if (rating >= 3.0) {
      return Colors.orange.shade700;
    } else {
      return Colors.red.shade600;
    }
  }
}
