import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xb/Controller/FavoriteController.dart';
import 'package:xb/Features/HomeScreen/Widgets/shopList.dart';
import 'package:xb/Services/Shop/TrendingShop.dart';
import 'package:xb/models/Shop/TrendingShopsModel.dart';
import '../Cart/CartScreen.dart';
import '../../Controller/CartController.dart';
import '../../Services/Shop/AllShopWithLocation.dart';
import '../../models/Shop/ShopModel.dart';
import '../../models/ShopModel.dart';
import '../Drawer/Drawers.dart';
import '../ShopScreen/Screen/ShopScreen.dart';
import 'Widgets/FoodAppBar.dart';
import 'Widgets/FoodListWidget.dart';
import 'Widgets/RestaurantListScreen.dart';
import 'Widgets/RewardBanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final allShopService = AllShopWithLocationService();
  List<Shop> shops = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  final trendingShopService = TrendingShopService();
  List<TrendingShop> trendingShops = [];
  bool isTrendingLoading = true;
  bool hasTrendingError = false;
  String trendingErrorMessage = '';

  // Local favorite set for sample restaurants
  final Set<String> sampleFavorites = {};

  @override
  void initState() {
    super.initState();
    _loadShops();
    _loadTrendingShops();
  }

  Future<void> _loadShops() async {
    try {
      setState(() {
        isLoading = true;
        hasError = false;
        errorMessage = '';
      });

      String city = "Mumbai";
      List<Shop> fetchedShops = await allShopService.fetchShopsByCity(city);

      setState(() {
        shops = fetchedShops;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      print("Error loading shops: $e");
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = _getErrorMessage(e);
      });
    }
  }

  Future<void> _loadTrendingShops() async {
    try {
      setState(() {
        isTrendingLoading = true;
        hasTrendingError = false;
        trendingErrorMessage = '';
      });

      String city = "Mumbai";
      String state = "Maharashtra";
      List<TrendingShop> fetchedTrendingShops =
      await trendingShopService.fetchShopsByCity(city, state);

      setState(() {
        trendingShops = fetchedTrendingShops;
        isTrendingLoading = false;
        hasTrendingError = false;
      });
    } catch (e) {
      print("Error loading trending shops: $e");
      setState(() {
        isTrendingLoading = false;
        hasTrendingError = true;
        trendingErrorMessage = _getErrorMessage(e);
      });
    }
  }

  String _getErrorMessage(dynamic error) {
    String errorStr = error.toString().toLowerCase();
    if (errorStr.contains('socket') ||
        errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('host lookup failed')) {
      return 'No internet connection';
    } else if (errorStr.contains('server') || errorStr.contains('500')) {
      return 'Server error occurred';
    } else if (errorStr.contains('404')) {
      return 'Data not found';
    } else {
      return 'Something went wrong';
    }
  }

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: Drawers(),
      appBar: FoodAppBar(),
      body: Container(
        child: RefreshIndicator(
          color: Color(0xFFC2262D),
          onRefresh: () async {
            await Future.wait([
              _loadShops(),
              _loadTrendingShops(),
            ]);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodListWidget(),

                RewardBannerCarousel(
                  bannerImageUrls: [
                    'https://marketplace.canva.com/EAFKIvQG0XE/2/0/1600w/canva-black-and-white-special-promotion-burger-banner-landscape-02i-a7aM_k8.jpg',
                    "https://t3.ftcdn.net/jpg/03/76/35/10/360_F_376351067_bYQtX79EILjxAnKSV1mmIIDFk7L4IFck.jpg",
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Popular Shops",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// TRENDING SHOPS SECTION
                _buildTrendingSection(),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Top Restaurants to Explore",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),

                /// SHOP LIST SECTION
                _buildShopListSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingSection() {
    if (isTrendingLoading) {
      return _buildShimmerTrending();
    } else if (hasTrendingError) {
      return _buildErrorWidget(
        message: trendingErrorMessage,
        onRetry: _loadTrendingShops,
        isHorizontal: true,
      );
    } else if (trendingShops.isEmpty) {
      return _buildEmptyWidget("No popular shops found", isHorizontal: true);
    } else {
      return RestaurantHorizontalWidget(
        restaurants: trendingShops.map((shop) {
          return RestaurantData(
            prepTime: shop.avgPreparationTime,
            isFavorite: sampleFavorites.contains(shop.name),
            name: shop.name,
            category: shop.cuisine.isNotEmpty ? shop.cuisine.first : "N/A",
            rating: shop.rating.average.toDouble(),
            deliveryTime: "${shop.avgPreparationTime > 0 ? shop.avgPreparationTime : 15} mins",
            imageUrl: shop.image.isNotEmpty
                ? shop.image
                : (shop.coverImage.isNotEmpty ? shop.coverImage : ""),
            backgroundColor: Colors.white,
          );
        }).toList(),
        onRestaurantTap: (restaurant) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShopScreen(restaurant: restaurant),
            ),
          );
        },
        onFavoriteToggle: (restaurant) {
          setState(() {
            if (sampleFavorites.contains(restaurant.name)) {
              sampleFavorites.remove(restaurant.name);
            } else {
              sampleFavorites.add(restaurant.name);
            }
          });
        },
        isFavorite: (restaurant) => sampleFavorites.contains(restaurant.name),
      );
    }
  }

  Widget _buildShopListSection() {
    if (isLoading) {
      return _buildShimmerList();
    } else if (hasError) {
      return _buildErrorWidget(
        message: errorMessage,
        onRetry: _loadShops,
        isHorizontal: false,
      );
    } else if (shops.isEmpty) {
      return _buildEmptyWidget("No restaurants found", isHorizontal: false);
    } else {
      return ListView.builder(
        itemCount: shops.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var shop = shops[index];
          return Obx(
                () => ShopList(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopScreen(
                      restaurant: RestaurantData(
                        prepTime: shop.avgPreparationTime,
                        address: shop.location.fullAddress,
                        isFavorite: favoriteController.isFavorite(shop),
                        name: shop.name,
                        category: shop.cuisine.isNotEmpty ? shop.cuisine.first : "N/A",
                        rating: shop.rating.average,
                        deliveryTime: "${shop.estimatedPreparationTime > 0 ? shop.estimatedPreparationTime : shop.avgPreparationTime} mins",
                        imageUrl: shop.image ?? shop.coverImage ?? "",
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              shopModel: ShopModel(
                avgTime: shop.avgPreparationTime,
                imageUrl: shop.image ?? shop.coverImage ?? "",
                restaurantName: shop.name,
                address: shop.location.fullAddress,
                stamps: shop.totalOrders.toString(),
                backgroundColor: Colors.white,
              ),
              isFavorite: favoriteController.isFavorite(shop),
              onFavoriteToggle: () {
                if (favoriteController.isFavorite(shop)) {
                  favoriteController.removeFavorite(shop);
                } else {
                  favoriteController.addFavorite(shop);
                }
                setState(() {});
              },
            ),
          );
        },
      );
    }
  }

  Widget _buildErrorWidget({
    required String message,
    required VoidCallback onRetry,
    required bool isHorizontal,
  }) {
    if (isHorizontal) {
      return _buildShimmerTrending();
    } else {
      return _buildShimmerList();
    }
  }

  Widget _buildEmptyWidget(String message, {required bool isHorizontal}) {
    if (isHorizontal) {
      return _buildShimmerTrending();
    } else {
      return _buildShimmerList();
    }
  }

  /// SHIMMER FOR SHOP LIST
  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 60,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 150,
                          height: 12,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// SHIMMER FOR TRENDING
  Widget _buildShimmerTrending() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 14,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 80,
                          height: 12,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 60,
                          height: 10,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}